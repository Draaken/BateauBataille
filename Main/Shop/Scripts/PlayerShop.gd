extends Node2D

var player_infos
var team
var LeftControl
var RightControl
var DownControl

var CoinGauge

var is_auctionning
var can_input = true

func _ready():
	is_auctionning = true
	$Timer.wait_time = 0.1
	$Timer.one_shot = true
	

func _process(_delta):
	if is_auctionning && can_input:
		if Input.is_action_pressed(RightControl) && player_infos.coins > 0:
			auction_more()
			
		if Input.is_action_pressed(LeftControl) && player_infos.auction_coins > 0:
			auction_less()

func update():
	player_infos.auction_coins = 0
	LeftControl = player_infos.LeftControl
	RightControl = player_infos.RightControl
	DownControl = player_infos.DownControl
	CoinGauge.value = player_infos.coins

func _on_auction_finished():
	is_auctionning = false

func auction_more():
	player_infos.coins -= 1
	player_infos.auction_coins += 1
	print("auction +1")
	updateHUD()
	
	can_input = false
	$Timer.start()
	
func auction_less( ):
	player_infos.coins += 1
	player_infos.auction_coins -= 1
	print("auction -1")
	updateHUD()
	
	can_input = false
	$Timer.start()
	
func updateHUD():
	CoinGauge.value = player_infos.coins


func _on_timer_timeout():
	can_input = true
