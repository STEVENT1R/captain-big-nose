extends Node2D

@export var speed: float = 50.0
var direction: float = 1.0 # 1 يمين / -1 شمال

# حدود الحركة
var min_x: float = -2000
var max_x: float = 2000

func _process(delta):
	position.x += direction * speed * delta

	wrap_custom_range()

func wrap_custom_range():
	if position.x > max_x:
		position.x = min_x

	elif position.x < min_x:
		position.x = max_x
