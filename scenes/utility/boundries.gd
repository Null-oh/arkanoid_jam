extends StaticBody2D

signal ded

func _on_death_body_entered(body):
	if body.name == "Ball" or body.name == "ball":
		body.linear_velocity = Vector2.ZERO
		ded.emit()
		print("[boundries] ded")
