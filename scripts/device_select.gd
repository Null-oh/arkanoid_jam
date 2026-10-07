extends Control

func _ready() -> void:
	Global.load_game()
	if Global.device == "mobile":
		Global.loading_scene_path = "res://scenes/main.tscn"
		get_tree().change_scene_to_file(Global.loading_screen_path)
	elif Global.device == "pc":
		Global.loading_scene_path = "res://scenes/start.tscn"
		get_tree().change_scene_to_file(Global.loading_screen_path)
	else:
		pass

func _on_mobile_btn_pressed() -> void:
	Global.device = "mobile"
	Global.save_game()
	Global.loading_scene_path = "res://scenes/main.tscn"
	get_tree().change_scene_to_file(Global.loading_screen_path)

func _on_desktop_btn_pressed() -> void:
	Global.device = "pc"
	Global.save_game()
	Global.loading_scene_path = "res://scenes/start.tscn"
	get_tree().change_scene_to_file(Global.loading_screen_path)
