extends UpgradeClass


func _init():
	upgrade_name = "Better Sails"
	upgrade_description = "Sail faster, not better."
	upgrade_type = "basic"

func setup(player):
	player.player_infos.speed += 10
