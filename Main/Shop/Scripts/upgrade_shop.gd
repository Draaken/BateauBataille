extends MarginContainer


var upgrade_ressource

func _ready():
	$HBoxContainer/VBoxContainer/Name.text = upgrade_ressource.upgrade_name
	$HBoxContainer/VBoxContainer/Description.text = upgrade_ressource.upgrade_description
	
	if upgrade_ressource.upgrade_type == "special":
		$HBoxContainer/VBoxContainer/Type.text = "Special"
		$HBoxContainer/VBoxContainer/Type.show()
	elif upgrade_ressource.upgrade_type == "canon_ball":
		$HBoxContainer/VBoxContainer/Type.text = "Canon Ball"
		$HBoxContainer/VBoxContainer/Type.show()
	
	unselect()


func bought(player):
	
	#ajouter une option pour choisir de garder l'ancien upgrade ou de la remplacer, dans le cas des slots à upgrade uniques
	
	var upgrade_type_array: Array
	if upgrade_ressource.upgrade_type == "special":
		upgrade_type_array = player.specialUpgrades
	elif upgrade_ressource.upgrade_type == "canon_ball":
		upgrade_type_array = player.canonBallUpgrades
	else:
		upgrade_type_array = player.basicUpgrades

	
	var already_acquired = false
	for upgrade in upgrade_type_array:
		if upgrade == upgrade_ressource:
			already_acquired = true
			var can_upgrade = upgrade.level_up()
			print(upgrade.upgrade_name)
			print("level" + str(upgrade.level))
			if not can_upgrade:
				player.coins += 3
			break
			
	if not already_acquired:
		if upgrade_ressource.upgrade_type == "special":
			player.specialUpgrades = [upgrade_ressource.duplicate()]
		elif upgrade_ressource.upgrade_type == "canon_ball":
			player.canonBallUpgrades = [upgrade_ressource.duplicate()]
		else:
			player.basicUpgrades.append(upgrade_ressource.duplicate())
			
	self.queue_free()
	$"..".remove_child(self)
	
		
func select(player):
	$"HBoxContainer/IconContainer/Border".show()
	$"HBoxContainer/IconContainer/Border".color = player.team_infos.color
	$"HBoxContainer/Winner".show()
	$"HBoxContainer/Winner".text = player.player_infos.HUDName
	
func unselect():
	$"HBoxContainer/IconContainer/Border".hide()
	$"HBoxContainer/Winner".text = ""
	
