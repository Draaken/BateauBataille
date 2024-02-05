extends UpgradeClass


func _init():
	upgrade_name = "Master gunner"
	upgrade_description = "Reload faster."
	upgrade_type = "basic"

func setup(player):
	player.get_node("Boat").reload_time -= 0.5
	player.get_node("Boat").reload_time = clamp(player.get_node("Boat").reload_time, 0.1, 100.0)
