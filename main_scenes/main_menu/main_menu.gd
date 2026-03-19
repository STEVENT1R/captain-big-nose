extends Control





func _on_enter_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter":
		$enter_animation.play("play")
	if anim_name == "play":
		get_tree().change_scene_to_file("res://main_scenes/main_island/main_island.tscn")
	if anim_name == "exit":
		get_tree().quit()
