extends UpgradeClass

func _init():
	upgrade_name = "Greased Helm"
	upgrade_description = "Turn faster."
	upgrade_type = "basic"
	max_level = 10

func setup(player):
	match level:
		1: 
			player.get_node("Boat").rotation_acc += 2
			player.get_node("Boat").rotation_max += 0.3
		2: 
			player.get_node("Boat").rotation_acc += 3.5
			player.get_node("Boat").rotation_max += 0.5
		3:
			player.get_node("Boat").rotation_acc += 4.5
			player.get_node("Boat").rotation_max += 0.7
		4:
			player.get_node("Boat").rotation_acc += 5
			player.get_node("Boat").rotation_max += 0.8
		_: 
			player.get_node("Boat").rotation_acc += 5 + (level-4)*0.4
			player.get_node("Boat").rotation_max += + (level-4)* 0.1
