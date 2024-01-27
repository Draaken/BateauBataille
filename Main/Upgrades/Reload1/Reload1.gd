extends UpgradeClass


func _init():
	upgrade_name = "Master gunner"
	upgrade_description = "Reload faster."
	upgrade_type = "basic"

func setup(player):
	player.get_node("Boat").reload_time -= 0.5
	clamp(player.get_node("Boat").reload_time, 0.0, 100.0)
