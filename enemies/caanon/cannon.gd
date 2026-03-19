extends CharacterBody2D

var player = null

@export var b : PackedScene
@export var marker : Marker2D

@onready var cannon_anim = $cannon

var die = false
var can_shot = true
var health = 1


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += 500 * delta
	
	move_and_slide()

	if health <= 0:
		die_()

	if die:
		return

	if can_shot == false and $pig.animation != "shot":
		$pig.play("idle")


func shot():
	if not can_shot:
		return
		
	can_shot = false
	$pig.play("shot")


func spawn_ball():

	var ball = b.instantiate()

	if scale.x == 1:
		ball.dir = 1
	else:
		ball.dir = -1

	ball.global_position = marker.global_position
	get_parent().add_child(ball)

	cannon_anim.play("fire")

	cooldown()


func cooldown() -> void:

	await get_tree().create_timer(1).timeout
	can_shot = true
	
	if player != null:
		shot()


func _on_pig_frame_changed() -> void:
	if $pig.animation == "shot" and $pig.frame == 2:
		spawn_ball()


func die_():

	if die:
		return

	die = true
	$pig.play("die")
	$pig.position = Vector2(-18,-7)
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack_area"):
		health -= 1


func _on_see_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		shot()


func _on_pig_animation_finished() -> void:
	if $pig.animation == "shot":
		$pig.play("idle")
