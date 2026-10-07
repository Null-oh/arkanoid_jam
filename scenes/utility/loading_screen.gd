extends Control

var target_scene_path

var loading_status : int
var progress : Array[float]
@onready var flag : bool = true

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready() -> void:
	target_scene_path = Global.loading_scene_path
	
	if !target_scene_path or target_scene_path == "":
		print("NO TARGET SCENE")
		return
	ResourceLoader.load_threaded_request(target_scene_path)

func _process(_delta: float) -> void:
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 #изменение значения бегунка
		
		ResourceLoader.THREAD_LOAD_LOADED:
			if flag:
				progress_bar.value = [96, 97, 98, 99, 100].pick_random() #хаха
				flag = false
			
			#защита от "гонки потоков": если нет дерева, скипаем этот фрейм в process
			if not is_inside_tree():
				return
			
			await get_tree().create_timer(0.5).timeout
			
			#защита от "гонки потоков": если нет дерева, скипаем этот фрейм в process
			if not is_inside_tree():
				return
			
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
		
		ResourceLoader.THREAD_LOAD_FAILED:
			print("LOADING ERROR")
