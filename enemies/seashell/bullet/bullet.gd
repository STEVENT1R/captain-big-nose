extends Area2D

var dir = 1

var speed = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position.x += speed * dir
	
	if $AnimatedSprite2D.frame == 4:
		queue_free()
	pass

func dis():
	speed = 0
	$Sprite2D.visible = false
	$AnimatedSprite2D.play("dis")
	
	$AnimatedSprite2D.visible = true 

func _on_body_entered(body: Node2D) -> void:
	dis()
	
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	dis()
	pass # Replace with function body.
