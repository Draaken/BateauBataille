extends SpecialMoveClass


var mine = preload("res://Main/Upgrades/Mines/mine_object.tscn")
signal mine_launched

var arm_time = 1
var explosion_radius = 70

func _init():
	upgrade_name = "Mines"
	upgrade_description = "KABOOOOM"
	duration = 0.3
	cooldown = 4
	max_level
	super()
#	self.connect("mine_launched", Callable($"../../../..", "receive_mine"))

func setup(connected_player):
	match level:
		1: explosion_radius = 70
		2: explosion_radius = 100
		3: explosion_radius = 120

func activate():
	var instance = mine.instantiate()
	var spawn = player.get_node("Boat/Upgrades/SpecialMove/MineSpawn")
#	emit_signal("mine_launched", instance, $MineSpawn.global_position, $MineSpawn.global_rotation, arm_time)
	level_scene.receive_mine(instance, spawn.global_position, spawn.global_rotation, arm_time)
	#Send a signal to the Player so that he create the mine there


func desactivate():
	pass
	

	
