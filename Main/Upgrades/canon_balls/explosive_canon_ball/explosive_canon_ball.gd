extends UpgradeClass

var explosive_canon_balls = preload("res://Main/Upgrades/canon_balls/explosive_canon_ball/ExplosiveCanonBallObject.tscn")
var radius

func _init():
	upgrade_name = "Explosive Canon Ball"
	upgrade_description = "Just have to time it right"
	upgrade_type = "canon_ball"
	max_level = 3

func setup(player):
	player.get_node("Boat").canon_ball_spawned.connect(player_shot)
	player.get_node("Boat").canon_ball = explosive_canon_balls
	match level:
		1: radius = 40
		2: radius = 65
		3: radius = 85
		
func player_shot(canon_ball):
	canon_ball.explosion_radius = radius
