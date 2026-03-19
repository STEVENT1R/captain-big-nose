extends Node2D



@export var distory_pices : Node2D

@export var distory_pices1 : RigidBody2D
@export var distory_pices2 : RigidBody2D



@export var coll : CollisionShape2D
@export var coll2 : CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	coll.disabled = true 
	
	coll2.disabled = true  
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	pass

func dis():
	
	
	
	
	distory_pices.visible = true
	
	
	distory_pices1.freeze = false
	
	distory_pices2.freeze = false
	
	
	coll.disabled = false 
	
	coll2.disabled = false  
	
