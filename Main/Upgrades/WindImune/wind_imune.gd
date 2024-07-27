extends UpgradeClass


func _init():
	upgrade_name = "Aeolus' Sail"
	upgrade_description = "Sail against the winds!"
	upgrade_type = "basic"
	max_level = 3

func setup(player):
#wind imunity between 0 and 1 reduce the negative effect of wind, over 1 it also boost the positive effect
	match level:
		1: player.get_node("Boat").wind_imunity = 1
		2: player.get_node("Boat").wind_imunity = 2
		3: player.get_node("Boat").wind_imunity = 3

