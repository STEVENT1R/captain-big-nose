extends CharacterBody2D

var no_player = false 
var left_right = true 
var run_to_player = false
var health = 1
var speed = randf_range(40,80)
var die = false
var idle = true
var gravity = 20
var dir = 1
var jump_velocity = 300

var attacking = false 
var flip = false
var take_hit = false 

@onready var anim_sprite := $AnimatedSprite2D

@export var ray : RayCast2D
@export var area_hit_player : Area2D
@export var jump_ray : RayCast2D
@export var bar : ProgressBar
@export var hit_attack : CollisionShape2D
@export var see_player : CollisionShape2D

@onready var player:= get_tree().get_root().find_child("captain",true,false )

func _ready() -> void:
	randomize()
	$Timer.wait_time = randf_range(1,30)

func _physics_process(delta: float) -> void:
	if die:
		return

	# لو بياخد ضربة، يوقف الحركة ويشغل Take Hit
	if take_hit:
		velocity = Vector2.ZERO
		anim_sprite.play("take_hit")
		move_and_slide()
		return

	# لو بيهاجم، يوقف الحركة ويشغل Attack
	if attacking:
		velocity = Vector2.ZERO
		attack()
		move_and_slide()
		return

	# الحركة العادية
	move()
	jump()
	attack_to()
	anim()
	health_bar()
	move_and_slide()

# =====================
# الصحة والموت
# =====================
func health_bar():
	if health <= 0 and not die:
		die_()

func die_():
	die = true
	attacking = false
	take_hit = false
	velocity = Vector2.ZERO
	anim_sprite.play("die")
	await anim_sprite.animation_finished
	queue_free()

# =====================
# الحركة
# =====================
func move():
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0

	velocity.x = dir * speed

	if not ray.is_colliding():
		run_to_player = false
		no_player = true
	else:
		no_player = false

	if dir == 1 and run_to_player == false:
		left_right = true
	elif dir == -1 and run_to_player == false:
		left_right = false 

	if not ray.is_colliding() and is_on_floor() and flip == false:
		scale.x = -scale.x
		dir *= -1
		flip = true
		await get_tree().create_timer(1).timeout
		flip = false 

	if jump_ray.is_colliding() and is_on_wall() and flip == false and is_on_floor() and run_to_player == false:
		scale.x = -scale.x
		dir *= -1
		flip = true
		await get_tree().create_timer(1).timeout
		flip = false

func jump():
	
	if is_on_wall() and is_on_floor() and not jump_ray.is_colliding():
		
		var collision = get_last_slide_collision()
		
		if collision:
			var collider = collision.get_collider()
			
			# لو الجسم اللي قدامه مش اللاعب
			if not collider.is_in_group("player"):
				velocity.y -= jump_velocity

# =====================
# أنيميشنات
# =====================
func anim():
	if die or take_hit or attacking:
		return

	if not is_on_floor():
		if velocity.y < 0:
			anim_sprite.play("jump")
		else:
			anim_sprite.play("fall")
		return

	if velocity.x != 0:
		anim_sprite.play("run")
	else:
		anim_sprite.play("idle")

# =====================
# هجوم
# =====================
func attack():
	anim_sprite.play("attack")

	if anim_sprite.animation == "attack":
		match anim_sprite.frame:
			1:
				hit_attack.disabled = true
				see_player.disabled = false 
			2:
				hit_attack.disabled = false
				see_player.disabled = true
			4:
				hit_attack.disabled = true
				see_player.disabled = false 
				attacking = false

func attack_to():
	if not ray.is_colliding():
		scale.x = -scale.x
		dir *= -1
		run_to_player = false 

	if run_to_player:
		if left_right:
			if position.x > player.position.x and flip == false:
				scale.x = -scale.x
				dir *= -1
				flip = true
			elif position.x < player.position.x and flip == true:
				scale.x = -scale.x
				dir *= -1
				flip = false  
		else:
			if position.x < player.position.x and flip == false:
				scale.x = -scale.x
				dir *= -1
				flip = true
			elif position.x > player.position.x and flip == true:
				scale.x = -scale.x
				dir *= -1
				flip = false 

# =====================
# الاصطدامات
# =====================
func _on_see_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("captain"):
		attacking = true
		run_to_player = true 

func hit(damage):
	if die: return
	if take_hit == false:
		health -= damage
		take_hit = true
		velocity = Vector2.ZERO
		anim_sprite.play("take_hit")

func _on_timer_timeout() -> void:
	$Timer.wait_time = randf_range(1,30)
	randomize()
	dir *= -1 

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack_area"):
		hit(1)

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "attack":
		attacking = false
	if anim_sprite.animation == "take_hit":
		take_hit = false
