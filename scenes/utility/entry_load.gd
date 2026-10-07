extends Control

var target_scene_path

var loading_status : int
var is_loading : bool
var progress : Array[float]

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready() -> void:
	set_start_scene()
	
	ResourceLoader.load_threaded_request(target_scene_path)

func _process(_delta: float) -> void:
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	loading()

func set_start_scene():
	if Global.device != "" and Global.device != "pc" and Global.device != "mobile":
		target_scene_path = "res://scenes/device_select.tscn"
	else:
		match Global.device:
			"": 
				target_scene_path = "res://scenes/device_select.tscn"
			"mobile": 
				target_scene_path = "res://scenes/main.tscn"
			"pc": 
				target_scene_path = "res://scenes/start.tscn"

func loading():
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 #изменение значения бегунка
		ResourceLoader.THREAD_LOAD_LOADED:
			progress_bar.value = 99
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("LOADING ERROR")
