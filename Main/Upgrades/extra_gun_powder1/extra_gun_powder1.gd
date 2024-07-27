extends UpgradeClass

func _init():
	upgrade_name = "Extra Gun Powder"
	upgrade_description = "More powder, more range."
	upgrade_type = "basic"
	max_level = 3

func setup(player):
	match level:
		1: player.get_node("Boat").canon_strength_modifier += 250
		2: player.get_node("Boat").canon_strength_modifier += 450
		3: player.get_node("Boat").canon_strength_modifier += 600
		4: player.get_node("Boat").canon_strength_modifier += 750
		_: player.get_node("Boat").canon_strength_modifier += 750 + (level - 4)*100
		
