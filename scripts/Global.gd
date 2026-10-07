extends Node

#general game info
var endless_record : int

var levels : Array[int] #все уровни, которые добавили в игру (по номерам для простоты)
var completed_levels : Array[int]

#level info
var broken_bricks : Dictionary[String, int]
var current_goal : Dictionary[String, int]
var endless_goal : Dictionary[String, int]
var extra_lives : int = 0
var active_bonuses : Array[String]

#save info
var device : String = "":
	set(value):
		if device != value:
			print("DEVICE changed from ", device, " to ", value)
			device = value


var tutorial : bool #0 - not seen, 1 - seen
var sound_volume : float = 100.0
var music_volume : float = 100.0
const SAVE_PATH = "user://savegame.json"

#load info
var loading_screen_path = "res://scenes/utility/loading_screen.tscn"
#при каждом переходе со сцены передаём нужную следующую сюда
var loading_scene_path = ""

func reset_current():
	broken_bricks.clear()
	current_goal.clear()
	endless_goal.clear()
	extra_lives = 0
	active_bonuses = []

func reset_whole():
	device = ""
	tutorial = false
	endless_record = 0
	completed_levels = []

func save_game():
	var data : Dictionary = {
		"device": device,
		"tutorial": tutorial,
		"endless_record": endless_record,
		"completed_levels": completed_levels,
		"sound_volume": sound_volume,
		"music_volume": music_volume
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(data))
	
	file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("NO SAVE FILE")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	var text_data = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(text_data)
	
	#if data != TYPE_DICTIONARY:
	if !data:
		print("ERROR WHILE LOADING GAME")
		return
	else:
		if !data["device"]:
			device = ""
		else:
			device = data["device"]
		
		if !data["tutorial"]:
			tutorial = 0
		else:
			tutorial = data["tutorial"]
		
		if !data["endless_record"]:
			endless_record = 0
		else:
			endless_record = data["endless_record"]
		
		if !data["completed_levels"]:
			completed_levels = []
		else:
			completed_levels = data["completed_levels"]
		
		if !data["sound_volume"]:
			sound_volume = 100.0
		else:
			sound_volume = data["sound_volume"]
		
		if !data["music_volume"]:
			music_volume = 100.0
		else:
			music_volume = data["music_volume"]
