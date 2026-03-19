extends CharacterBody2D


var no_player = false 


var left_right = true 

var run_to_player = false

var health = 3
var speed = randf_range(40,60)
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




@export var hit_attack : CollisionShape2D

@export var see_player : CollisionShape2D

@onready var player:= get_tree().get_root().find_child("captain",true,false )



func _ready() -> void:
	randomize()
	$Timer.wait_time = randf_range(1,30)
	

func _physics_process(delta: float) -> void:
	if die:
		# لو مات، ما يتحركش أو يعمل أي حاجة
		return

	if take_hit:
		# لو بياخد ضربة، يوقف الحركة
		velocity = Vector2.ZERO
		anim()
		move_and_slide()
		return

	if attacking:
		# لو بيهاجم، يوقف الحركة العادية
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

func health_bar():
	if health <= 0 and not die:
		die_()


func move():
	if not is_on_floor():
		velocity.y += gravity
	
	
	velocity.x = dir * speed
	
	
	if not ray.is_colliding():
		run_to_player = false
		no_player = true
	
	if ray.is_colliding():
		no_player = false
	
	
	if dir == 1 && run_to_player == false:
		left_right = true
	if dir == -1 && run_to_player == false:
		left_right = false 
	
	if not ray.is_colliding() && is_on_floor() && flip == false :
		scale.x = -scale.x
		dir *= -1
		
		flip = true
		await get_tree().create_timer(1).timeout
		flip = false 
		

	
	
	if jump_ray.is_colliding():
		
		if is_on_wall() && flip == false && is_on_floor() && run_to_player == false :
			scale.x = -scale.x
			dir *= -1
			
			
			flip = true
			await get_tree().create_timer(1).timeout
			flip = false 
	
	
func anim():
	if die or take_hit or attacking:
		return

	if velocity.y < 0:
		anim_sprite.play("jump")
		return
		
	if velocity.y > 0:
		anim_sprite.play("fall")
		return
	
	if velocity.x != 0:
		anim_sprite.play("run")


func attack():
	
	
	
	anim_sprite.play("attack")
	
	if anim_sprite.animation == "attack":
		
		match anim_sprite.frame:
			1:
				hit_attack.disabled = false
				see_player.disabled = false 
			2:
				hit_attack.disabled = true
				see_player.disabled = true
	await get_tree().create_timer(2).timeout
	attacking = false


func attack_to():
	
	if not ray.is_colliding():
		scale.x = -scale.x
		dir *= -1
		run_to_player = false 
	if run_to_player == true && left_right == true :
		
		
		if position > player.position && flip == false :
			scale.x = -scale.x
			dir *= -1
			flip = true
			
		if position < player.position && flip == true:
			scale.x = -scale.x
			dir *= -1
			flip = false  
			

	if run_to_player == true && left_right == false :
		if position < player.position && flip == false :
			scale.x = -scale.x
			dir *= -1
			flip = true
			
		
		if position > player.position && flip == true  :
			scale.x = -scale.x
			dir *= -1
			flip = false 


func _on_see_player_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("captain"):
		attacking = true
		run_to_player = true 
		
	
	pass # Replace with function body.




func hit(damage):
	if die: return  # لو مات بالفعل، ما ينفعش ياخد ضربة تانية

	if take_hit == false:
		health -= damage
		take_hit = true
		velocity = Vector2.ZERO  # يوقف الحركة فورًا
		anim_sprite.play("take_hit")

func _on_timer_timeout() -> void:
	
	
	$Timer.wait_time = randf_range(1,30)
	
	randomize()
	
	dir *= -1 
	
	pass # Replace with function body.

func jump():
	
	if is_on_wall() and is_on_floor() and not jump_ray.is_colliding():
		
		var collision = get_last_slide_collision()
		
		if collision:
			var collider = collision.get_collider()
			
			# لو الجسم اللي قدامه مش اللاعب
			if not collider.is_in_group("player"):
				velocity.y -= jump_velocity
func die_():
	die = true          # نوقف كل الحركة فورًا
	attacking = false
	take_hit = false
	velocity = Vector2.ZERO
	anim_sprite.play("die")
	await anim_sprite.animation_finished
	queue_free()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack_area"):
		hit(1)


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "attack":
		attacking = false
	if anim_sprite.animation == "take_hit":
		take_hit = false
