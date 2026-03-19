extends RigidBody2D


var distory = false 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if distory == false:
		$CollisionShape2D.disabled = true
		gravity_scale = 0
		visible = false
	if distory == true:
		
		$CollisionShape2D.disabled = false
		gravity_scale = 1
		visible = true
	
	pass
