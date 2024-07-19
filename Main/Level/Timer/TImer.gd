extends Node2D
var round_lenght = 100
var coin_spawn_time = 10

signal spawnCoin

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainTimer.connect("timeout", Callable(self, "_on_round_end"))
	$MainTimer.one_shot = true
	$"MainTimer".wait_time = round_lenght
	
	$"CenterContainer/ProgressBar".max_value = round_lenght/coin_spawn_time
	$"CenterContainer/ProgressBar".value = round_lenght/coin_spawn_time
	
	$CoinTimer.connect("timeout", Callable(self, "coin_timer_up"))
	$CoinTimer.one_shot = true
	$CoinTimer.wait_time = coin_spawn_time

func _process(_delta):
	$CenterContainer/Label.text = str(int($MainTimer.time_left))

func start():
	
	$"MainTimer".start()
	$CoinTimer.start()
	
func _on_round_end():
	pass

func spawn_coin():
	emit_signal("spawnCoin")
	$CoinTimer.start()
	$AudioStreamPlayer.play()
	
func coin_timer_up():
	if $"CenterContainer/ProgressBar".value > 0:
		spawn_coin()
		$"CenterContainer/ProgressBar".value -= 1
