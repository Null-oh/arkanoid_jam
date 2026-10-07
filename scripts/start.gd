extends Control

@onready var debug: Label = $debug

func _on_start_pressed() -> void:
	#ДЕМО - ТЕСТОВЫЙ УРОВЕНЬ
	Global.loading_scene_path = "res://scenes/levels/testing.tscn"
	
	#ЧИСТОВИК:
	#Global.loading_scene_path = "res://scenes/main.tscn"
	
	get_tree().change_scene_to_file("res://scenes/utility/loading_screen.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_save_pressed() -> void:
	Global.save_game()

func _on_load_pressed() -> void:
	Global.load_game()
	
	debug.text = "device: " + str(Global.device) + "\n" + \
	"tutorial: " +  str(Global.tutorial) + "\n" + \
	"endless_record: " +  str(Global.endless_record) + "\n" + \
	"completed_levels: "+  str(Global.completed_levels) + "\n" + \
	"sound_volume: "+  str(Global.sound_volume) + "\n" + \
	"music_volume: " +  str(Global.music_volume)

func _on_clear_pressed() -> void:
	Global.reset_whole()
	Global.save_game()
