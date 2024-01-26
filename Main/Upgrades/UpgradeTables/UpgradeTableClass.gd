class_name UpgradeTableClass extends Resource

var table = []
var mines = preload("res://Main/Upgrades/Resources/mines.tres")
var rear_canon =  preload("res://Main/Upgrades/Resources/rear_canon.tres")
var dash =  preload("res://Main/Upgrades/Resources/dash.tres")
var hp1 = preload("res://Main/Upgrades/Resources/HP1.tres")
var speed1 = preload("res://Main/Upgrades/Resources/speed1.tres")
var wind_imune = preload("res://Main/Upgrades/Resources/wind_imune.tres")

var rng = RandomNumberGenerator.new()


func get_upgrade():
	if table.size() > 0:
		var upgrade_number = rng.randi_range(0,table.size()-1)
		return table[upgrade_number]
	else:
		print_debug("Upgrade table is empty.")
