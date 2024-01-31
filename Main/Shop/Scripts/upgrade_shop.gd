extends MarginContainer


var upgrade_resource

func _ready():
	$HBoxContainer/VBoxContainer/Name.text = upgrade_resource.upgrade_name
	$HBoxContainer/VBoxContainer/Description.text = upgrade_resource.upgrade_description
	
	if upgrade_resource.upgrade_type == "special":
		$HBoxContainer/VBoxContainer/Special.show()
	
	unselect()


func bought(player):
	
	$"HBoxContainer/Winner".text = player.HUDName
	
	if upgrade_resource.upgrade_type == "special":
		player.specialUpgrades = [upgrade_resource.duplicate()]
	else:
		player.basicUpgrades.append(upgrade_resource.duplicate())
		
	self.queue_free()
	$"..".remove_child(self)
	
		
func select(player):
	$"HBoxContainer/IconContainer/Border".show()
	$"HBoxContainer/IconContainer/Border".color = player.team_infos.color
	
func unselect():
	$"HBoxContainer/IconContainer/Border".hide()
	
