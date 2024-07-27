class_name UpgradeTableClass extends Resource

@export var table: Array[Resource]= []

var rng = RandomNumberGenerator.new()


func get_upgrade():
	if table.size() > 0:
		var upgrade_number = rng.randi_range(0,table.size()-1)
		return table[upgrade_number]
	else:
		print_debug("Upgrade table is empty.")
