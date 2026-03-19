extends Area2D



func _ready() -> void:
	randomize()
	var random = randi_range(1,4)
	$AnimatedSprite2D.play(str(random))
	
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		PlayerData.map_pieces += 1
		$AnimatedSprite2D.play("take")


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "take":
		queue_free()
