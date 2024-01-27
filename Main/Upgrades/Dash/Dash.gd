extends SpecialMoveClass


var speedA = 1100
var speedDA = 200
var target_velocity_boost = 150


func _init():
	upgrade_name = "Ram"
	upgrade_description = "Evade and ram your ennemies."
	duration = 0.5
	cooldown = 4
	super()
	
func setup(connected_player):
	player = connected_player
	player.get_node("Boat").connect("rammed", Callable(self, "rammed"))

func activate():
	
	startAcc(boat)

func desactivate():
	endAcc()
	
	
func startAcc(boat):
	boat.is_dashing = true
	
	boat.boost_velocity_goal = target_velocity_boost
	boat.boost = speedA
	boat.ram_damage = 1
	
	
	
	
func endAcc():
	boat.is_dashing = false
	
	boat.boost_velocity_goal = 0
	boat.boost = speedDA
	boat.ram_damage = 0
		
	
func rammed():
	boat.is_dashing = false
	
	boat.boost_velocity_goal = 0
	boat.boost = speedDA
	boat.boost_velocity /= 2
	boat.ram_damage = 0
