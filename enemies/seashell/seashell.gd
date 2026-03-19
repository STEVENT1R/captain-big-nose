extends CharacterBody2D

# =========================
# STATES
# =========================

var take_hit = false 
var shot = false
var die = false
var attacking = false 

var health = 3

var facing_dir = 1  

@export var b : PackedScene

@onready var anim_player = $AnimatedSprite2D
@onready var marker = $Marker2D
@onready var area_attack = $areas/attack_player/CollisionShape2D
@export var see_player : CollisionShape2D
@export var ray_shot : RayCast2D


# =========================
# PROCESS
# =========================

func _process(delta: float) -> void:

	if die:
		return
	
	if health <= 0:
		die_()
		return
	
	if take_hit:
		return
	
	if attacking:
		handle_attack_frames()
		return
	
	shoting()

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


# =========================
# SHOOT SYSTEM
# =========================

func shoting():

	if take_hit or attacking:
		return
	
	if ray_shot.is_colliding():
		
		var body = ray_shot.get_collider()

		if body.is_in_group("captain") and shot == false:
			
			shot = true 
			anim_player.play("shot")

			await get_tree().create_timer(0.4).timeout

			var bullet = b.instantiate()
			bullet.global_position = marker.global_position
			bullet.dir = sign(marker.global_position.x - global_position.x)

			get_parent().add_child(bullet)

			await get_tree().create_timer(1).timeout
			
			shot = false


# =========================
# ATTACK SYSTEM (صح 100٪)
# =========================

func _on_see_player_body_entered(body: Node2D) -> void:

	if body.is_in_group("captain") and !take_hit:

		attacking = true
		anim_player.play("attack")


func handle_attack_frames():
	if anim_player.animation != "attack":
		return
	
	if $AnimatedSprite2D.animation == "attack":
		if anim_player.frame == 3:
			area_attack.disabled = false
		else:
			area_attack.disabled = true



# =========================
# DIE
# =========================

func die_():

	anim_player.play("die")
	die = true
	
	$CollisionShape2D.disabled = true 
	$distory.distory = true
	
	await get_tree().create_timer(0.3).timeout
	
	anim_player.visible = false


# =========================
# HIT
# =========================

func hit(dameg):
	health -= dameg
	take_hit = true 
	anim_player.play("hit")


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "hit":
		take_hit = false
		$AnimatedSprite2D.play("idle")
	elif $AnimatedSprite2D.animation == "attack":
		attacking = false
		area_attack.disabled = true


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack_area"):
		hit(1)
