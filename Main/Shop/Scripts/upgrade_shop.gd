extends MarginContainer


var upgrade_ressource

func _ready():
	$HBoxContainer/VBoxContainer/Name.text = upgrade_ressource.upgrade_name
	$HBoxContainer/VBoxContainer/Description.text = upgrade_ressource.upgrade_description
	
	if upgrade_ressource.upgrade_type == "special":
		$HBoxContainer/VBoxContainer/Special.show()
	
	unselect()


func bought(player):
	
	
	if upgrade_ressource.upgrade_type == "special":
		player.specialUpgrades = [upgrade_ressource.duplicate()]
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
	
