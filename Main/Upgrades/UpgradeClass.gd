class_name UpgradeClass extends Resource

var upgrade_name = "Default"
var upgrade_description = "Default"
var icon = null
var upgrade_type = "default" #default, special
var level = 1
var max_level = 6
var rarity = 1


func _init():
	pass


func setup(player):
	pass

func level_up():
	if level + 1 <= max_level:
		level += 1
		return true
	else:
		return false
