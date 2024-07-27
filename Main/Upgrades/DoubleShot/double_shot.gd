extends UpgradeClass
var owner
var random = RandomNumberGenerator.new()
var is_active = true
var chance_of_second_shot = 0

func _init():
	upgrade_name = "Double Shot"
	upgrade_description = "A chance to fire a second canon ball"
	upgrade_type = "basic"
	max_level = 5

func setup(player):
	random.randomize()
	player.get_node("Boat").shot.connect(player_shot)
	owner = player
	
	match level:
		1: chance_of_second_shot = 30
		2: chance_of_second_shot = 50
		3: chance_of_second_shot = 65
		4: chance_of_second_shot = 75
		5: chance_of_second_shot = 80
	
func player_shot(direction, canon_ball):
	if is_active && random.randf_range(0,100)> 100-chance_of_second_shot:
		is_active = false
		await owner.get_tree().create_timer(0.3).timeout
		match direction:
			"left":
				owner.get_node("Boat").shootLeft(true)
			"right":
				owner.get_node("Boat").shootRight(true)
			_:
				pass
		await owner.get_tree().create_timer(0.8).timeout
		is_active = true
