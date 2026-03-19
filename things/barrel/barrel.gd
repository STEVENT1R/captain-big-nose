extends RigidBody2D



@export var distory_pices : Node2D

@export var sprite : AnimatedSprite2D

@export var distory_pices1 : RigidBody2D
@export var distory_pices2 : RigidBody2D
@export var distory_pices3 : RigidBody2D
@export var distory_pices4 : RigidBody2D


@export var coll : CollisionShape2D
@export var coll2 : CollisionShape2D
@export var coll3 : CollisionShape2D
@export var coll4 : CollisionShape2D

@export var collisionShape : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	coll.disabled = true 
	
	coll2.disabled = true  
	
	coll3.disabled = true 
	
	coll4.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	pass

func dis():
	
	gravity_scale = 0
	
	collisionShape.disabled = true
	
	distory_pices.visible = true
	
	sprite.visible = false
	
	distory_pices1.freeze = false
	
	distory_pices2.freeze = false
	
	distory_pices3.freeze = false
	
	distory_pices4.freeze = false
	
	coll.disabled = false 
	
	coll2.disabled = false  
	
	coll3.disabled = false 
	
	coll4.disabled = false  

func _on_hurt_box_area_exited(area: Area2D) -> void:
	
	if area.is_in_group(""):
		dis()
	
	pass # Replace with function body.
