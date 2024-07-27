extends UpgradeClass


func _init():
	upgrade_name = "Upgraded equipment"
	upgrade_description = "Faster special"
	upgrade_type = "basic"
	max_level = 10

func setup(player):
	var cooldown_modifier
	if player.player_infos.specialUpgrades.size()>0:
		match level:
			1: cooldown_modifier = player.player_infos.specialUpgrades[0].cooldown/10*sqrt(level)

		player.get_node("Boat").special_cooldown_multiplier += cooldown_modifier
		player.get_node("Boat").special_cooldown_multiplier = clamp(player.get_node("Boat").special_cooldown_multiplier, 0.2, 2)
