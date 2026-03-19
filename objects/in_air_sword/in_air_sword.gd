extends Area2D




var speed = 6
var dir = 1

func _process(delta: float) -> void:
	position.x += speed * dir
	$AnimatedSprite2D.scale.x = dir


func _on_body_entered(body: Node2D) -> void:
	queue_free()
