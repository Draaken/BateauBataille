extends SpecialMoveClass


var speedA = 18
var speedDA = 3
var target_speed = 150


func _init():
	upgrade_name = "Dash"
	upgrade_description = "Wiiiiiiih"
	duration = 0.5
	cooldown = 4
	super()
	
func setup(connected_player):
	player = connected_player

func activate():
	
	startAcc(boat)

func desactivate():
	endAcc()
	
	
func startAcc(boat):
	boat.has_rammed = false
	boat.is_dashing = true
	
	boat.boost_velocity_goal = target_speed
	boat.boost = speedA
	boat.ram_damage = 1
	
	
	
	
func endAcc():
	boat.is_dashing = false
	
	boat.boost_velocity_goal = 0
	boat.boost = speedDA
	boat.ram_damage = 0
		
	
