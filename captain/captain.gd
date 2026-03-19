extends CharacterBody2D


var speed = 180
var jump_force = -300
var gravity = 800

@export var have_sword = true

var animation
var hitbox

# ======================
# نظام الكومبو
# ======================
var is_attacking = false
var combo_step = 0
var air_combo_step = 0

var combo_timer = 0.0
var combo_reset_time = 0.4

var health = 3
var taking_hit = false
var die = false

@onready var run_dust = $run_dust


func _ready() -> void:
	$UI.show()
	check_state()
	hitbox = $with_sword/hit_box/floor
	hitbox.disabled = true

@onready var fall_vfx: AnimatedSprite2D = $fall_vfx


func _physics_process(delta: float) -> void:
	if taking_hit == false and die == false:
		move(delta)
	update_combo_timer(delta)
	if is_on_floor():
		hitbox = $with_sword/hit_box/floor
	else:
		hitbox = $with_sword/hit_box/air
	
	if Input.is_action_just_pressed("throw_sword") and have_sword == true and is_attacking == false and taking_hit == false:
		throw_sword()
	
	# ===== run dust =====
	if not is_attacking and is_on_floor():
		if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			run_dust.visible = true
			run_dust.scale.x = animation.scale.x
			if not run_dust.is_playing():
				run_dust.play()
		else:
			run_dust.visible = false
			run_dust.stop()
	else:
		run_dust.visible = false
		run_dust.stop()
	
	# ===== fall VFX =====
	if not is_attacking and is_on_floor() == false and velocity.y > 0:
		fall_vfx.visible = true
		fall_vfx.scale.x = animation.scale.x
		if not fall_vfx.is_playing():
			fall_vfx.play("fall")
	else:
		fall_vfx.visible = false

func _process(delta: float) -> void:
	$UI/player_ui/health_bar/health_bar.value = health
	_die()
	check_state()

func check_state():
	if have_sword:
		animation = $with_sword
	else:
		animation = $no_sword
	
	$no_sword.visible = !have_sword
	$with_sword.visible = have_sword

func move(delta):
	var direction = 0
	
	if not is_attacking:
		if Input.is_action_pressed("right"):
			direction += 1
		if Input.is_action_pressed("left"):
			direction -= 1
	
	velocity.x = direction * speed
	
	if not is_attacking:
		if direction != 0:
			animation.play("run")
			animation.scale.x = sign(direction)
		else:
			animation.play("idle")
	
	if is_on_floor() and Input.is_action_just_pressed("jump") and not is_attacking:
		velocity.y = jump_force
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if not is_attacking:
			if velocity.y < 0:
				animation.play("jump")
			else:
				animation.play("fall")
	else:
		if velocity.y > 0:
			velocity.y = 0
	
	if Input.is_action_just_pressed("attack") and have_sword and not is_attacking:
		start_attack()
	
	move_and_slide()




# ======================
# الضرب
# ======================
func start_attack():
	is_attacking = true
	combo_timer = combo_reset_time
	
	if is_on_floor():
		ground_attack()
	else:
		air_attack()



func ground_attack():
	combo_step += 1
	if combo_step > 3:
		combo_step = 1
	
	match combo_step:
		1:
			animation.play("attack1")
		2:
			animation.play("attack2")
		3:
			animation.play("attack3")



func air_attack():
	air_combo_step += 1
	if air_combo_step > 2:
		air_combo_step = 1
	
	match air_combo_step:
		1:
			animation.play("air_attack1")
		2:
			animation.play("air_attack2")



func update_combo_timer(delta):
	if combo_timer > 0:
		combo_timer -= delta
	else:
		combo_step = 0
		air_combo_step = 0


func _on_with_sword_frame_changed() -> void:
	if not is_attacking:
		hitbox.set_deferred("disabled", true)
		return
	
	var current_anim = animation.animation
	
	if current_anim.begins_with("attack") or current_anim.begins_with("air_attack"):
		if animation.frame == 1:
			hitbox.set_deferred("disabled", false)
		else:
			hitbox.set_deferred("disabled", true)
	else:
		hitbox.set_deferred("disabled", true)



func _on_with_sword_animation_finished():
	if animation.animation == "hit":
		taking_hit = false
	is_attacking = false
	hitbox.disabled = true
	if animation.animation == "throw_sword":
		is_attacking = false


func _on_no_sword_animation_finished() -> void:
	if animation.animation == "hit":
		taking_hit = false


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_attack_area") && health > 0:
		health -= 1
		animation.play("hit")
		taking_hit = true



# ======================
# رمي السيف
# ======================
func throw_sword():
	if not have_sword:
		return
	
	have_sword = false
	animation.play("throw_sword")
	is_attacking = true
	
	
	var sword_instance = preload("res://objects/in_air_sword/in_air_sword.tscn").instantiate()
	sword_instance.global_position = $with_sword/sword_pos.global_position
	sword_instance.dir = animation.scale.x
	get_parent().add_child(sword_instance)



func _die():
	if health <= 0 and not die:
		taking_hit = false
		die = true
		animation.play("dead_hit")
		
	
