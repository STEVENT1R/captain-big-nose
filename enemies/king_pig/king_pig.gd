extends CharacterBody2D


var no_player = false 


var left_right = true 

var run_to_player = false

var health = 50
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
		
	
	if attacking or take_hit:
		
		attack()
		
		return
	move()
	anim()
	jump()
	health_bar()
	attack_to()
	move_and_slide()

func health_bar():
	if health <= 0 && is_on_floor():
		die_()
		die = true
		
	bar.value = health



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
	
	
	
	if velocity.x:
		anim_sprite.play("run")
	
	
	if velocity.y < 0:
		anim_sprite.play("jump")
	elif velocity.y > 0:
		anim_sprite.play("fall")
	

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
	
	if take_hit == false:
		
		health -= damage
		
		take_hit = true
		anim_sprite.play("take_hit")
		
		await get_tree().create_timer(1).timeout
		take_hit = false 


func _on_timer_timeout() -> void:
	
	
	$Timer.wait_time = randf_range(1,30)
	
	randomize()
	
	dir *= -1 
	
	pass # Replace with function body.

func jump():
	
	
	
	if is_on_wall() && not jump_ray.is_colliding() && is_on_floor():
		
		velocity.y -= jump_velocity
	
func die_():
	
	$ProgressBar.visible = false 
	
	$CollisionShape2D.disabled = true
	$ray/hit_attack/see_player/CollisionShape2D.disabled = true 
	
	anim_sprite.play("die")
	die = true
