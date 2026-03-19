extends Area2D


var speed = 4
var dir = 1
var destroy = false


func _process(delta: float) -> void:
	position.x += speed * dir
	
	if destroy == false:
		$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D.scale.x = dir
	
	pass





func _on_body_entered(body: Node2D) -> void:
	_destroy()


func _destroy():
	speed = 0
	destroy = true
	$AnimatedSprite2D.play("destroyed")
	
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "destroyed":
		queue_free()
