extends CanvasLayer

@onready var label: Label = $ColorRect/Label

@onready var ball: RigidBody2D = $"../Ball"

func _process(_delta: float) -> void:
	label.text = "Speed: " + str(sqrt(ball.linear_velocity.x ** 2 + ball.linear_velocity.y ** 2))
