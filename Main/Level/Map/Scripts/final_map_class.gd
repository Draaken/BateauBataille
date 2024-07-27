class_name final_map_class extends map_class


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_up_defenses(defending_team):
	var temp_position
	var temp_rotation
	
	if defending_team == 1:
		temp_position = $"Starting Positions/P1".position
		$"Starting Positions/P1".position = $"Starting Positions/P2".position
		$"Starting Positions/P2".position = temp_position
		
		temp_position = $"Starting Positions/P3".position
		$"Starting Positions/P3".position = $"Starting Positions/P4".position
		$"Starting Positions/P4".position = temp_position
		
		temp_rotation = $"Starting Positions/P1".rotation
		$"Starting Positions/P1".rotation = $"Starting Positions/P2".rotation
		$"Starting Positions/P2".rotation = temp_rotation
		
		temp_rotation = $"Starting Positions/P3".rotation
		$"Starting Positions/P3".rotation = $"Starting Positions/P4".rotation
		$"Starting Positions/P4".rotation = temp_rotation
	
	if get_node("Canons"):
		for node in get_node("Canons").get_children():
			if not node.is_neutral:
				node.team = defending_team
			else:
				node.team = 0
