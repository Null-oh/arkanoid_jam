extends CanvasLayer

@onready var start = $start
signal begin #присоединить к уровню
@onready var fail = $fail
@onready var win = $win

@onready var progress_jar = $header/MarginContainer/HBoxContainer/progress_jar
@onready var goal_info = $header/MarginContainer/HBoxContainer/goal_info
@onready var lives_label = $header/MarginContainer/HBoxContainer/right_side/HBoxContainer/lives_label

var parent
var extra_lives : int

func _ready():
	start.visible = true
	fail.visible = false
	win.visible = false
	
	extra_lives = Global.extra_lives
	progress_jar.max_value = 100.0
	progress_jar.value = 0.0
	
	parent = get_parent()
	if parent:
		if parent.has_signal("super_ded"):
			parent.super_ded.connect(totally_ded)
		if parent.level_number and parent.level_number != 0:
			pass #тут добавить назначение следующей сцены

func _process(delta):
	win.visible = check_for_win()
	lives_label.text = str(extra_lives)
	
	progress_jar.value = Global.get_goal_progress() * 100.0

func check_for_win():
	for brick in Global.current_goal:
		if Global.broken_bricks.get(brick, 0) < Global.current_goal[brick]:
			return false
	return true

func set_progress_goal():
	progress_jar.value = 0
	progress_jar.max_value = 0
	for child in goal_info.get_children():
		progress_jar.max_value += child.amount
	print("[lvl interface] max_jar = ", progress_jar.max_value)


func totally_ded():
	extra_lives -= 1
	if extra_lives <= 0:
		fail.visible = true

func _on_retry_pressed():
	Global.reset_current()
	Global.loading_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/utility/loading_screen.tscn")

func _on_exit_pressed():
	Global.reset_current()
	
	#ТЕСТ
	Global.loading_scene_path = "res://scenes/start.tscn"
	
	#ЧИСТОВИК
	#Global.loading_scene_path = "res://scenes/main.tscn"
	
	get_tree().change_scene_to_file("res://scenes/utility/loading_screen.tscn")

func _on_temp_start_pressed():
	start.visible = false
	begin.emit()

func _on_next_pressed():
	Global.reset_current()
	
	#ТЕСТ
	Global.loading_scene_path = "res://scenes/start.tscn"
	#в чистовике пропишется путь к нужному следующему уровню
	
	get_tree().change_scene_to_file("res://scenes/utility/loading_screen.tscn")
