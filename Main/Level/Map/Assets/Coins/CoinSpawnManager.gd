extends Node2D
#script of the coin spawn manager
var timer = Timer.new()
var random = RandomNumberGenerator.new()

var respawn_randomness = 0.0
var respawn_time = 2
var coin_spawners_count



func _ready():
	coin_spawners_count = $"CoinList".get_child_count()
	
	random.randomize()
	add_child(timer)
	timer.one_shot = true
	
	spawn()
	
func spawn():
	var new_coin
	var new_coin_number
	
	new_coin_number = random.randi_range(0, coin_spawners_count - 1)
	new_coin = $"CoinList".get_child(new_coin_number)
	while new_coin.is_active:
		new_coin_number = random.randi_range(0, coin_spawners_count - 1)
		new_coin = $"CoinList".get_child(new_coin_number)
	
	timer.wait_time = respawn_time * (1.0 - random.randf_range(0.0, respawn_randomness))
	timer.start()
	await timer.timeout
	
	new_coin.activate()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
