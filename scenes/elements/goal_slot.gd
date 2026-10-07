extends HBoxContainer

#ДОБАВИТЬ ОСТАЛЬНЫЕ
@export_enum("sugar", "apple", "strawberry") var ingredient : String
## Ввести 0, чтобы удалить слот
@export_range(0, 50, 1, "suffix:шт") var amount : int

@onready var icon = $icon #ВРЕМЕННАЯ ИКОНКА
@onready var quantity = $quantity


func _ready():
	if amount == 0 or ingredient == "":
		self.queue_free()
		return
	
	set_slot()
	
	Global.current_goal[ingredient] = amount
	#print("[slot] Global.current_goal = ", Global.current_goal)

func set_slot():
	#здесь будет настройка картинки
	match ingredient:
		"sugar": icon.color = Color(0.848, 0.76, 0.846, 1.0)
		"apple": icon.color = Color(0.946, 0.382, 0.392, 1.0)
		"strawberry": icon.color = Color(0.711, 0.227, 0.37, 1.0)

func _process(delta):
	if Global.broken_bricks.has(ingredient):
		quantity.text = str(Global.broken_bricks[ingredient]) + "/" + str(amount)
	else:
		quantity.text = "0/" + str(amount)
