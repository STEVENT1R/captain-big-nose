extends Node2D



func _process(delta: float) -> void:
	UI()
	



func UI():
	$"../panels/levels/panel/potions/golden_skull/golden_skull".visible = PlayerData.golden_skull > 0
	$"../panels/levels/panel/potions/blue_potion/blue_potion".visible = PlayerData.blue_potion > 0
	$"../panels/levels/panel/potions/red_potion/red_potion".visible = PlayerData.red_potion > 0
	$"../panels/levels/panel/potions/green_potion/green_potion".visible = PlayerData.green_potion > 0
	
	$"../panels/levels/panel/potions/golden_skull/own".text = str(PlayerData.golden_skull)
	$"../panels/levels/panel/potions/blue_potion/own".text = str(PlayerData.blue_potion)
	$"../panels/levels/panel/potions/red_potion/own".text = str(PlayerData.red_potion)
	$"../panels/levels/panel/potions/green_potion/own".text = str(PlayerData.green_potion)
	
	if Global.current_level >= 2:
		$"../panels/levels/panel/levels/level2".disabled = false
		$"../panels/levels/panel/levels/level2/lock".visible = false
	if Global.current_level >= 3:
		$"../panels/levels/panel/levels/level3".disabled = false
		$"../panels/levels/panel/levels/level3/lock".visible = false
	if Global.current_level >= 4:
		$"../panels/levels/panel/levels/level4".disabled = false
		$"../panels/levels/panel/levels/level4/lock".visible = false
	if Global.current_level >= 5:
		$"../panels/levels/panel/levels/level5".disabled = false
		$"../panels/levels/panel/levels/level5/lock".visible = false
	if Global.current_level >= 6:
		$"../panels/levels/panel/levels/level6".disabled = false
		$"../panels/levels/panel/levels/level6/lock".visible = false
	if Global.current_level >= 7:
		$"../panels/levels/panel/levels/level7".disabled = false
		$"../panels/levels/panel/levels/level7/lock".visible = false
	if Global.current_level >= 8:
		$"../panels/levels/panel/levels/level8".disabled = false
		$"../panels/levels/panel/levels/level8/lock".visible = false
	if Global.current_level >= 9:
		$"../panels/levels/panel/levels/level9".disabled = false
		$"../panels/levels/panel/levels/level9/lock".visible = false
	if Global.current_level >= 10:
		$"../panels/levels/panel/levels/level10".disabled = false
		$"../panels/levels/panel/levels/level10/lock".visible = false
	if Global.current_level >= 11:
		$"../panels/levels/panel/levels/level11".disabled = false
		$"../panels/levels/panel/levels/level11/lock".visible = false
	if Global.current_level >= 12:
		$"../panels/levels/panel/levels/level12".disabled = false
		$"../panels/levels/panel/levels/level12/lock".visible = false
	if Global.current_level >= 13:
		$"../panels/levels/panel/levels/level13".disabled = false
		$"../panels/levels/panel/levels/level13/lock".visible = false
	if Global.current_level >= 14:
		$"../panels/levels/panel/levels/level14".disabled = false
		$"../panels/levels/panel/levels/level14/lock".visible = false
	if Global.current_level >= 15:
		$"../panels/levels/panel/levels/level15".disabled = false
		$"../panels/levels/panel/levels/level15/lock".visible = false
	if Global.current_level >= 16:
		$"../panels/levels/panel/levels/level16".disabled = false
		$"../panels/levels/panel/levels/level16/lock".visible = false
	if Global.current_level >= 17:
		$"../panels/levels/panel/levels/level17".disabled = false
		$"../panels/levels/panel/levels/level17/lock".visible = false
	if Global.current_level >= 18:
		$"../panels/levels/panel/levels/level18".disabled = false
		$"../panels/levels/panel/levels/level18/lock".visible = false
	if Global.current_level >= 19:
		$"../panels/levels/panel/levels/level19".disabled = false
		$"../panels/levels/panel/levels/level19/lock".visible = false
	if Global.current_level >= 20:
		$"../panels/levels/panel/levels/level20".disabled = false
		$"../panels/levels/panel/levels/level20/lock".visible = false
	if Global.current_level >= 21:
		$"../panels/levels/panel/levels/level21".disabled = false
		$"../panels/levels/panel/levels/level21/lock".visible = false
	if Global.current_level >= 22:
		$"../panels/levels/panel/levels/level22".disabled = false
		$"../panels/levels/panel/levels/level22/lock".visible = false
	if Global.current_level >= 23:
		$"../panels/levels/panel/levels/level23".disabled = false
		$"../panels/levels/panel/levels/level23/lock".visible = false
	if Global.current_level >= 24:
		$"../panels/levels/panel/levels/level24".disabled = false
		$"../panels/levels/panel/levels/level24/lock".visible = false
	if Global.current_level >= 25:
		$"../panels/levels/panel/levels/level25".disabled = false
		$"../panels/levels/panel/levels/level25/lock".visible = false
	if Global.current_level >= 26:
		$"../panels/levels/panel/levels/level26".disabled = false
		$"../panels/levels/panel/levels/level26/lock".visible = false
	if Global.current_level >= 27:
		$"../panels/levels/panel/levels/level27".disabled = false
		$"../panels/levels/panel/levels/level27/lock".visible = false
	if Global.current_level >= 28:
		$"../panels/levels/panel/levels/level28".disabled = false
		$"../panels/levels/panel/levels/level28/lock".visible = false
	if Global.current_level >= 29:
		$"../panels/levels/panel/levels/level29".disabled = false
		$"../panels/levels/panel/levels/level29/lock".visible = false
	if Global.current_level >= 30:
		$"../panels/levels/panel/levels/level30".disabled = false
		$"../panels/levels/panel/levels/level30/lock".visible = false
	if Global.current_level >= 31:
		$"../panels/levels/panel/levels/level31".disabled = false
		$"../panels/levels/panel/levels/level31/lock".visible = false
	if Global.current_level >= 32:
		$"../panels/levels/panel/levels/level32".disabled = false
		$"../panels/levels/panel/levels/level32/lock".visible = false
	if Global.current_level >= 33:
		$"../panels/levels/panel/levels/level33".disabled = false
		$"../panels/levels/panel/levels/level33/lock".visible = false
	if Global.current_level >= 34:
		$"../panels/levels/panel/levels/level34".disabled = false
		$"../panels/levels/panel/levels/level34/lock".visible = false
	if Global.current_level >= 35:
		$"../panels/levels/panel/levels/level35".disabled = false
		$"../panels/levels/panel/levels/level35/lock".visible = false
	if Global.current_level >= 36:
		$"../panels/levels/panel/levels/level36".disabled = false
		$"../panels/levels/panel/levels/level36/lock".visible = false
	if Global.current_level >= 37:
		$"../panels/levels/panel/levels/level37".disabled = false
		$"../panels/levels/panel/levels/level37/lock".visible = false
	if Global.current_level >= 38:
		$"../panels/levels/panel/levels/level38".disabled = false
		$"../panels/levels/panel/levels/level38/lock".visible = false
	if Global.current_level >= 39:
		$"../panels/levels/panel/levels/level39".disabled = false
		$"../panels/levels/panel/levels/level39/lock".visible = false
	if Global.current_level >= 40:
		$"../panels/levels/panel/levels/level40".disabled = false
		$"../panels/levels/panel/levels/level40/lock".visible = false
	if Global.current_level >= 41:
		$"../panels/levels/panel/levels/level41".disabled = false
		$"../panels/levels/panel/levels/level41/lock".visible = false
	if Global.current_level >= 42:
		$"../panels/levels/panel/levels/level42".disabled = false
		$"../panels/levels/panel/levels/level42/lock".visible = false
	if Global.current_level >= 43:
		$"../panels/levels/panel/levels/level43".disabled = false
		$"../panels/levels/panel/levels/level43/lock".visible = false
	if Global.current_level >= 44:
		$"../panels/levels/panel/levels/level44".disabled = false
		$"../panels/levels/panel/levels/level44/lock".visible = false
	if Global.current_level >= 45:
		$"../panels/levels/panel/levels/level45".disabled = false
		$"../panels/levels/panel/levels/level45/lock".visible = false
	if Global.current_level >= 46:
		$"../panels/levels/panel/levels/level46".disabled = false
		$"../panels/levels/panel/levels/level46/lock".visible = false
	if Global.current_level >= 47:
		$"../panels/levels/panel/levels/level47".disabled = false
		$"../panels/levels/panel/levels/level47/lock".visible = false
	if Global.current_level >= 48:
		$"../panels/levels/panel/levels/level48".disabled = false
		$"../panels/levels/panel/levels/level48/lock".visible = false
	if Global.current_level >= 49:
		$"../panels/levels/panel/levels/level49".disabled = false
		$"../panels/levels/panel/levels/level49/lock".visible = false
	if Global.current_level == 50:
		$"../panels/levels/panel/levels/level50".disabled = false
		$"../panels/levels/panel/levels/level50/lock".visible = false
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	pass




func _on_levels_ship_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../panels/levels/panel/panel_animation".play("show")


func _on_levels_ship_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../panels/levels/panel/panel_animation".play("hide")

func _on_close_pressed() -> void:
	$"../panels/levels/panel/panel_animation".play("hide")


func _on_golden_skull_pressed() -> void:
	if PlayerData.golden_skull > 0:
		Global.equiped_potion = "golden_skull"


func _on_blue_potion_pressed() -> void:
	if PlayerData.blue_potion > 0:
		Global.equiped_potion = "blue_potion"

func _on_red_potion_pressed() -> void:
	if PlayerData.red_potion > 0:
		Global.equiped_potion = "red_potion"


func _on_green_potion_pressed() -> void:
	if PlayerData.green_potion > 0:
		Global.equiped_potion = "green_potion"
