extends Control

signal shopFinished
signal auctionFinished

var player = preload("res://Main/Shop/Scenes/PlayerShop.tscn")
var upgrade_shop = preload("res://Main/Shop/Scenes/upgrade_shop.tscn")
var upgrade_table = preload("res://Main/Upgrades/UpgradeTables/upgrade_table1.tres")

var upgrades_list

func _ready():
#	pass
#	hide()
	upgrades_list = $"MarginContainer/GUI/Body/UpgradesList/VBoxContainer"

	$MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/Player1.hide()
	$MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/Player2.hide()
	$MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/Player3.hide()
	$MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/Player4.hide()
	
	
	if get_node("/root/Player1").is_playing:
		load_player("Player1")

	if get_node("/root/Player2").is_playing:
		load_player("Player2")

	if get_node("/root/Player3").is_playing:
		load_player("Player3")

	if get_node("/root/Player4").is_playing:
		load_player("Player4")
		
		
	randomize_upgrades($"..".players_list.size())
		

	$CandleTimer.wait_time = 20
	$CandleTimer.one_shot = true
	$CandleTimer.start()


func _process(delta):
	$MarginContainer/GUI/Body/Candle/ProgressBar.value = $CandleTimer.time_left*$MarginContainer/GUI/Body/Candle/ProgressBar.max_value/$CandleTimer.wait_time

func load_player(playerName):
	
	var instance = player.instantiate()
	var team 
#	var team = "Team1"
	
	
	add_child(instance)
	
	instance.player_infos = get_node("/root/" + playerName)
	team = "Team"+ str(instance.player_infos.team)
	instance.reparent(get_node(team))
	
	instance.team = get_node(team)


	instance.CoinGauge = get_node("MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/"+ playerName + "/ProgressBar")
	get_node("MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/"+ playerName + "/MarginContainer/Label").text = instance.player_infos.HUDName
	get_node("MarginContainer/GUI/Body/Treasure/MarginContainer2/Gauges/"+ playerName).show()
	instance.update()
	
	connect("auctionFinished", Callable(instance, "_on_auction_finished"))
	
func randomize_upgrades(number):
	if upgrade_table is Resource:
		for i in (number):
			var instance = upgrade_shop.instantiate()
			
			instance.upgrade_resource = upgrade_table.get_upgrade()
	
			upgrades_list.add_child(instance)
			
			instance.name = "Upgrade" + str(i+1)
	else:
		print_debug("Upgrade table is not the good format or absent")
	
func auction_results():
	var ranking = []
	
	
	for i in range(1, 5):
		var player = get_node("/root/Player" + str(i))
		if player.is_playing:
			ranking.append(player)

	
	ranking.sort_custom(sort_by_auction)
	
	for i in range(0, ranking.size()):
		upgrades_list.get_child(i).bought(ranking[i])
		print(ranking[i].auction_coins)
	
func sort_by_auction(a, b):
	if a.auction_coins > b.auction_coins:
		return true
	elif a.auction_coins < b.auction_coins:
		return false
#Determine pseudorandomly the winner in case of tie
	elif a.coins > b.coins:
		return false
	elif a.coins < b.coins:
		return true
		
	else:
		return false
	
	
	
func _on_button_pressed():
	emit_signal("shopFinished")


func _on_candle_timer_timeout():
	emit_signal("auctionFinished")
	auction_results()
	
