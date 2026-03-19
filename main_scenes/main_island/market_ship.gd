extends Node2D





func _process(delta: float) -> void:
	UI()
	


func UI():
	$"../panels/market/panel/inventory/coins/number".text = str(PlayerData.coins)
	$"../panels/market/panel/inventory/blue_diamonds/number".text = str(PlayerData.blue_diamond)
	$"../panels/market/panel/inventory/green_diamonds/number".text = str(PlayerData.green_diamond)
	$"../panels/market/panel/inventory/red_diamonds/number".text = str(PlayerData.red_diamond)
	
	$"../panels/market/panel/items/skull/owned".text = "Owned = " + str(PlayerData.golden_skull)
	$"../panels/market/panel/items/blue_potion/owned".text = "Owned = " + str(PlayerData.blue_diamond)
	$"../panels/market/panel/items/green_potion/owned".text = "Owned = " + str(PlayerData.green_potion)
	$"../panels/market/panel/items/red_potion/owned".text = "Owned = " + str(PlayerData.red_potion)
	
	if Global.remaining_ads == 2:
		$"../panels/market/panel/remaining".text = "*" + str(Global.remaining_ads) + " ADs Remaining"
	if Global.remaining_ads == 1:
		$"../panels/market/panel/remaining".text = "*" + str(Global.remaining_ads) + " AD Remaining"
	
	
	pass



func _on_market_ship_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../panels/market/panel/panel_animation".play("show")

func _on_market_ship_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../panels/market/panel/panel_animation".play("hide")


func _on_close_pressed() -> void:
	$"../panels/market/panel/panel_animation".play("hide")

func _on_buy_1_pressed() -> void:
	pass # Replace with function body.


func _on_buy_2_pressed() -> void:
	pass # Replace with function body.


func _on_buy_3_pressed() -> void:
	pass # Replace with function body.


func _on_buy_4_pressed() -> void:
	pass # Replace with function body.
