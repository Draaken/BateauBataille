extends UpgradeClass


func _init():
	upgrade_name = "Master gunner"
	upgrade_description = "Reload faster."
	upgrade_type = "basic"
	max_level = 10

func setup(player):
	match level:
		1: player.get_node("Boat").reload_time -= 0.6
		2: player.get_node("Boat").reload_time -= 1.2
		3: player.get_node("Boat").reload_time -= 1.8
		4: player.get_node("Boat").reload_time -= 2.4
		_: player.get_node("Boat").reload_time -= 2.4 + (level-4)* 0.5
	player.get_node("Boat").reload_time = clamp(player.get_node("Boat").reload_time, 0.1, 100.0)
