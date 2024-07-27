extends UpgradeClass

var chained_canon_balls = preload("res://Main/Upgrades/canon_balls/chained_canon_balls/ChainedCanonBallsScene.tscn")

func _init():
	upgrade_name = "Chained Canon Balls"
	upgrade_description = "Rip through your ennemies sails!"
	upgrade_type = "canon_ball"
	max_level = 1
	

func setup(player):
	player.get_node("Boat").canon_ball = chained_canon_balls
	player.get_node("Boat").canon_strength_modifier += -50
