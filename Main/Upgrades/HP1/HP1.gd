extends UpgradeClass


func _init():
	upgrade_name = "Improved Hull"
	upgrade_description = "+1 health point"
	upgrade_type = "basic"

func setup(player):
	player.player_infos.hit_points += 1
