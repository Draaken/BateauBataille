extends SpecialMoveClass


func _init():
	upgrade_name = "Sails of discretion"
	upgrade_description = "Turn your ship briefly invisible."
	duration = 0.3
	max_level = 3
	rarity = 2
	
	super()
	
func setup(connected_player):
	super(connected_player)
	player.get_node("Boat").has_been_hit.connect(hit)
	player.get_node("Boat").shot.connect(shot)
	cooldown = 6.5
	
	match level:
		1: duration = 2.0
		2: duration = 4.0
		3: duration = 6.0
		
	

func activate():
	start_invis()

func desactivate():
	end_invis()
	
func hit():
	end_invis()
	
func shot(a,b):
#don't mind the arguments but i have to accept them or the signal won't connect :(
	end_invis()

func start_invis():
	if not boat.is_invisible:
		boat.is_invisible = true
		player.visible = false
	
func end_invis():
	if boat.is_invisible:
		boat.is_invisible = false
		player.visible = true
