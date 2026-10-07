extends StaticBody2D

@onready var temp_texture: ColorRect = $temp_texture

@export_enum("sugar", "apple") var ingredient : String


func _on_collision_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		print(ingredient + " broken!")
		if Global.broken_bricks.has(ingredient):
			Global.broken_bricks[ingredient] += 1
		else:
			Global.broken_bricks[ingredient] = 1
		print("Global.croken_bricks = ", Global.broken_bricks)
		
		self.queue_free()
