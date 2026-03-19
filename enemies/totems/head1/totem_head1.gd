extends CharacterBody2D

# =========================
# STATES
# =========================

var is_attacking := false
var taking_hit := false
var health := 3

var bullet_shot := false

# =========================
# PHYSICS
# =========================

var gravity := 1200
var fall_speed := 0


# =========================
# PROCESS
# =========================

func _process(delta: float) -> void:

	# لو مش بيهاجم ولا متضرب → يرجع idle
	if !is_attacking and !taking_hit:
		$AnimatedSprite2D.play("idle")

	# 🔥 مراقبة الفريم داخل أنيميشن الضرب
	if $AnimatedSprite2D.animation == "attack":
		if $AnimatedSprite2D.frame == 3 and bullet_shot == false:
			shoot_bullet()
			bullet_shot = true


	# =========================
	# 🔥 الجاذبية عشان الرأس تقع لو اللي تحتها اتشال
	# =========================

	if not is_on_floor():
		fall_speed += gravity * delta
	else:
		fall_speed = 0

	velocity.y = fall_speed

	move_and_slide()


# =========================
# SHOOT DETECTION
# =========================

func _on_shoot_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attacking = true
		$AnimatedSprite2D.play("attack")


# =========================
# DAMAGE SYSTEM
# =========================

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack_area"):
		taking_hit = true
		$AnimatedSprite2D.play("hit")
		health -= 1

		if health <= 0:
			queue_free()


# =========================
# ANIMATION FINISHED
# =========================

func _on_animated_sprite_2d_animation_finished() -> void:

	if $AnimatedSprite2D.animation == "attack":
		is_attacking = false
		bullet_shot = false   # مهم عشان الهجمة الجاية تشتغل

	if $AnimatedSprite2D.animation == "hit":
		taking_hit = false


# =========================
# SHOOT FUNCTION
# =========================

func shoot_bullet():

	var bullet_scene = preload("res://enemies/totems/bullet/bullet.tscn")
	var bullet = bullet_scene.instantiate()

	bullet.global_position = $AnimatedSprite2D/bullet_pos.global_position
	
	# الاتجاه حسب اتجاه الرأس
	bullet.dir = -scale.x

	get_parent().add_child(bullet)
