extends Node2D

@export var level_number : int = 0

@onready var boundries = $boundries
signal super_ded
@onready var interface = $interface

@onready var ball = $Ball
@onready var ramp = $Ramp

func _ready():
	interface.begin.connect(on_begin)
	boundries.ded.connect(on_death)

func on_begin():
	ball.start = true
	ramp.start = true

func on_death():
	super_ded.emit()
	ball.linear_velocity = Vector2.ZERO
	ball.start = true
