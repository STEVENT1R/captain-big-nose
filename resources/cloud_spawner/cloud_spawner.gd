extends Node2D



@export var cloud_scene: PackedScene
@export var cloud_count: int = 60

func _ready():
	spawn_clouds()

func spawn_clouds():
	var viewport_size = get_viewport_rect().size
	
	for i in range(cloud_count):
		var cloud = cloud_scene.instantiate()
		add_child(cloud)
	
		# spawn في نفس الرينج
		cloud.position = Vector2(
			randf_range(-2500, 2500),
			randf_range(0, viewport_size.y * 0.4)
		)
	
		cloud.direction = [1, -1].pick_random()
		cloud.speed = randf_range(20, 60)
