extends UpgradeClass


func _init():
	upgrade_name = "Improved Hull"
	upgrade_description = "+1 health point"
	upgrade_type = "basic"
	max_level = 3

func setup(player):
	player.get_node("Boat").hit_points += level
