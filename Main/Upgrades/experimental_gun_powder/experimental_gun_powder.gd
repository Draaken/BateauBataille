extends UpgradeClass
var owner
var random = RandomNumberGenerator.new()

func _init():
	upgrade_name = "Experimental Gun Powder"
	upgrade_description = "Huge canonball velocity, with some risks..."
	upgrade_type = "basic"
	max_level = 1
	rarity = 3

func setup(player):
	random.randomize()
	player.get_node("Boat").canon_strength_modifier += 1000
	player.get_node("Boat").shot.connect(player_shot)
	owner = player
	
func player_shot(a,b):
	if random.randf_range(0,100)>90:
		owner.get_node("Boat").take_damage(1,"Explosion")
