extends SpecialMoveClass


var speedA = 20
var speedDA = -5
var acceleration = 0
var timerDash = Timer.new()
var base_speed
var target_speed
var timer_started = false
var canon


func _init():
	upgrade_name = "Rear Canon"
	upgrade_description = "Boom, boom, boom"
	duration = 6
	cooldown = 6
	max_level = 1
	super()

func setup(connected_player):
	super(connected_player)
	canon = player.get_node("Boat/Upgrades/SpecialMove/RearCanon")
	canon.show()
	canon.reload_time = cooldown
	

func activate():
	
	canon.shoot(player.get_node("Boat"))
	
func desactivate():
	pass
	
	
		
	
