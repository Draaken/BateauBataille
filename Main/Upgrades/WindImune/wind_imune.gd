extends UpgradeClass


func _init():
	upgrade_name = "Aeolus' Sail"
	upgrade_description = "Master the winds!"
	upgrade_type = "basic"

func setup(player):
	player.get_node("Boat").is_wind_imune = true
