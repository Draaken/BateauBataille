extends UpgradeClass


func _init():
	upgrade_name = "Better Sails"
	upgrade_description = "Sail faster, not better."
	upgrade_type = "basic"
	max_level = 10

func setup(player):
	var speed_boost = 0
	match level:
		1: speed_boost = 30
		2: speed_boost = 55
		3: speed_boost = 70
		4: speed_boost = 95
		_: speed_boost = 95 + (level-4)*10
		
	player.get_node("Boat").speed += speed_boost
