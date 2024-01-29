class_name SpecialMoveClass extends UpgradeClass



var is_ready = true


var player
var level
var boat
var special

#Parameters
var duration = 0
var cooldown = 4

# Called when the node enters the scene tree for the first time.

	

func _init():
	upgrade_type = "special"
	super()
	
#	timerCooldown.timeout.connect(Callable(self, "cooldownEnd"))
#	add_child(timerCooldown)
#
#
#	add_child(timerActive)
#
#	timerActive.connect("timeout", Callable(self, "desactivate"))
	
	


func start():
# Defines the path to the Boat and SpecialMove nodes of the player using the upgrade
	boat = player.get_node("Boat")
	special = boat.get_node("Upgrades/SpecialMove")
	level = player.get_node("/root/MasterScene/Level")
	
# Set up the timer nodes already existing in SpecialMove
	special.get_node("Cooldown").wait_time = cooldown
	special.get_node("Cooldown").one_shot = true
	special.get_node("Active").wait_time = duration
	special.get_node("Active").one_shot = true
	
	special.get_node("Cooldown").timeout.connect(Callable(self, "cooldownEnd"))
	special.get_node("Active").connect("timeout", Callable(self, "desactivate"))
	
	
	
	if is_ready == true:
		activate()
		special.get_node("Indicator").hide()
		is_ready = false
		special.get_node("Cooldown").start()
		special.get_node("Active").start()
			

func activate(): #Function overrided by nodes using this class to put the effects of the special
	pass

func desactivate():
	pass
	
func reset():
	pass

func cooldownEnd():
	reset()
	is_ready = true
	special.get_node("Indicator").show()
