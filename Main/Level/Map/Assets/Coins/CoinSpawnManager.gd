extends Node2D
#script of the coin spawn manager
var timer = Timer.new()
var random = RandomNumberGenerator.new()
var coin_spawners_count



func _ready():
	coin_spawners_count = $"CoinSpawnList".get_child_count()
	
	random.randomize()
	
	
func spawn():
	var new_coin_spawner
	var new_coin_spawner_number
	var already_a_coin
	
	new_coin_spawner_number = random.randi_range(0, coin_spawners_count - 1)
	new_coin_spawner = $"CoinSpawnList".get_child(new_coin_spawner_number)
	
	already_a_coin = false
	for coin in $CoinList.get_children():
		if coin.position == new_coin_spawner.position:
			already_a_coin = true
	
	while already_a_coin:
		new_coin_spawner_number = random.randi_range(0, coin_spawners_count - 1)
		new_coin_spawner = $"CoinSpawnList".get_child(new_coin_spawner_number)
		
		for coin in $CoinList.get_children():
			already_a_coin = false
			if coin.position == new_coin_spawner.position:
				already_a_coin = true
	
	new_coin_spawner.spawn_coin()
	
func final_pickup(team):
	if team == null:
		return
	if $CoinList.get_children():
		for coin in $"CoinList".get_children():
			var closest_boat
			var closest_distance
			for player in team.alive_players:
				var boat = player.get_node("Boat")
				var distance = coin.global_position.distance_to(boat.global_position)
				if closest_distance:
					if distance < closest_distance:
						closest_distance = distance
						closest_boat = boat
				else:
					closest_distance = distance
					closest_boat = boat
						
			coin.distance_to_target = closest_distance
			coin.go_toward(closest_boat)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
