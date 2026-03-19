extends RigidBody2D


var speed = 6
var dir = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(dir)
	position.x += speed * dir
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
