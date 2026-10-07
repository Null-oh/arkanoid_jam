extends StaticBody2D

@onready var temp_texture: ColorRect = $temp_texture

@export_enum("sugar", "apple") var ingredient : String

func _ready():
	match ingredient:
		"sugar": temp_texture.color = Color(0.848, 0.76, 0.846, 1.0)
		"apple": temp_texture.color = Color(0.946, 0.382, 0.392, 1.0)

func _on_collision_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		#print("[brick]" + ingredient + " broken!")
		if Global.broken_bricks.has(ingredient):
			Global.broken_bricks[ingredient] += 1
		else:
			Global.broken_bricks[ingredient] = 1
		#print("[brick] Global.broken_bricks = ", Global.broken_bricks)
		
		self.queue_free()
