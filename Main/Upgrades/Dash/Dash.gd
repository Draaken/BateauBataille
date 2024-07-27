extends SpecialMoveClass


var speedA = 1200
var speedDA = 200
var target_velocity_boost = 170


func _init():
	upgrade_name = "Ram"
	upgrade_description = "Evade, and ram your ennemies."
	duration = 0.6
	max_level = 3
	
	super()
	
func setup(connected_player):
	super(connected_player)
	player.get_node("Boat").connect("rammed", Callable(self, "rammed"))
	cooldown = 4
	
	match level:
		1: 
			speedA = 1200
			speedDA = 200
			target_velocity_boost = 170
			duration = 0.6
		2: 
			speedA = 1500
			speedDA = 250
			target_velocity_boost = 200
			duration = 0.7
		3: 
			speedA = 1700
			speedDA = 280
			target_velocity_boost = 220
			duration = 0.8
		
	

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
	boat.boost_velocity_goal = 0
	boat.boost = speedDA
	
	
	await boat.get_tree().create_timer(0.2).timeout
	boat.is_dashing = false
	boat.ram_damage = 0
	
	
func rammed():
	boat.is_dashing = false
	
	boat.boost_velocity_goal = 0
	boat.boost = speedDA
	boat.boost_velocity /= 2
	boat.ram_damage = 0
