extends StaticBody2D

@onready var launch: Marker2D = $launch
var launch_coords : Vector2

func _process(delta: float) -> void:
	launch_coords = launch.global_position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.global_position.x = event.position.x - 0.5 * get_viewport().get_visible_rect().size.x
