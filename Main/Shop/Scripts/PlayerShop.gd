extends Node2D

var player_infos
var team_infos
var team_node
var shop_node

var LeftControl
var RightControl
var DownControl

var CoinGauge

var is_auctionning = false
var is_choosing = false
var can_input = true

var old_selected_index = null
var selected_index = null


func _ready():
	is_auctionning = true
	is_choosing = false
	$Timer.wait_time = 0.1
	$Timer.one_shot = true
	

func _process(_delta):
	if is_auctionning && can_input:
		if Input.is_action_pressed(RightControl) && player_infos.coins > 0:
			auction_more()
			
		if Input.is_action_pressed(LeftControl) && player_infos.auction_coins > 0:
			auction_less()
			
	if is_choosing:
		#print_debug(selected_index)
		if Input.is_action_just_pressed(RightControl):
			select_next()
		if Input.is_action_just_pressed(LeftControl):
			select_previous()
		if Input.is_action_just_pressed(DownControl):
			buy()
			
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
	if selected_index != null:
		if old_selected_index != null:
			shop_node.selectable_list[old_selected_index].unselect()
		shop_node.selectable_list[selected_index].select(self)

func select_next():
	if selected_index != null:
		old_selected_index = selected_index
		selected_index += 1
		selected_index = clamp(selected_index, 0, shop_node.upgrades_parent.get_child_count() -1)
		updateHUD()
	
func select_previous():
	if selected_index != null:
		old_selected_index = selected_index
		selected_index -= 1
		selected_index = clamp(selected_index, 0, shop_node.upgrades_parent.get_child_count() -1)
		updateHUD()

func buy():
	if selected_index != null:
		shop_node.selectable_list[selected_index].bought(player_infos)
		selected_index = null
		shop_node.next_active_chooser()

func _on_timer_timeout():
	can_input = true
