extends Control

signal shopFinished
signal auctionFinished

var playerShop = preload("res://Main/Shop/Scenes/PlayerShop.tscn")
var upgrade_shop = preload("res://Main/Shop/Scenes/upgrade_shop.tscn")
var upgrade_table = preload("res://Main/Upgrades/UpgradeTables/upgrade_table1.tres")

var players_list = []

var upgrades_parent
var selectable_list = []
var active_chooser_index = 0
var ranking = []

func _ready():
#	pass
#	hide()
	upgrades_parent = $"MarginContainer/GUI/Body/UpgradesList/VBoxContainer"

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
	

	randomize_upgrades(players_list.size())
		

	$CandleTimer.wait_time = 20
	$CandleTimer.one_shot = true
	$CandleTimer.start()


func _process(_delta):
	$MarginContainer/GUI/Body/Candle/ProgressBar.value = $CandleTimer.time_left*$MarginContainer/GUI/Body/Candle/ProgressBar.max_value/$CandleTimer.wait_time

func load_player(playerName):
	
	var instance = playerShop.instantiate()
	var team 
#	var team = "Team1"
	
	
	add_child(instance)
	players_list.append(instance)
	
	instance.player_infos = get_node("/root/" + playerName)
	team = "Team"+ str(instance.player_infos.team)
	instance.reparent(get_node(team))
	
	instance.shop_node = self
	instance.team_node = get_node(team)
	instance.team_infos = get_node("/root/" + team )


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
	
			upgrades_parent.add_child(instance)
			
			instance.name = "Upgrade" + str(i+1)
	else:
		print_debug("Upgrade table is not the good format or absent")
	
func auction_results():
	
	change_selectable(upgrades_parent.get_children())
	
	ranking = []
	
	
	for i in range(0, players_list.size()):
		print(players_list.size())
		var player = players_list[i]
		ranking.append(player)

	
	ranking.sort_custom(sort_by_auction)
	
	ranking[active_chooser_index].is_choosing = true
	ranking[active_chooser_index].selected_index = 0
	ranking[active_chooser_index].updateHUD()
	

func next_active_chooser():
	if active_chooser_index < players_list.size() -1 :
		change_selectable(upgrades_parent.get_children())
		
		ranking[active_chooser_index].is_choosing = false
		active_chooser_index += 1
		ranking[active_chooser_index].is_choosing = true
		
		ranking[active_chooser_index].selected_index = 0
		ranking[active_chooser_index].old_selected_index = null
		ranking[active_chooser_index].updateHUD()
		#select the first selectableq
	else:
		emit_signal("shopFinished")

func sort_by_auction(a, b):
	
	var a_infos = a.player_infos
	var b_infos = b.player_infos
	
	if a_infos.auction_coins > b_infos.auction_coins:
		return true
	elif a_infos.auction_coins < b_infos.auction_coins:
		return false
#Determine pseudorandomly the winner in case of tie
	elif a_infos.coins > b_infos.coins:
		return false
	elif a_infos.coins < b_infos.coins:
		return true
		
	else:
		return false
	

func reset_selection():
	
	for i in range(0, selectable_list.size() ):
		selectable_list[i].unselect()
		
	
func _on_button_pressed():
	
	emit_signal("shopFinished")


func _on_candle_timer_timeout():
	
	emit_signal("auctionFinished")
	auction_results()
	

	
func change_selectable(new_selectable_list: Array):
		reset_selection()
		selectable_list = new_selectable_list
	
