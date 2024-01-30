class_name Player extends Node2D

signal specialUsed


var LeftControl
var RightControl
var DownControl
var SpawnPosition
var SpawnRotation

var timerL = Timer.new()
var timerR = Timer.new()
var timerNoTurn = Timer.new()

var double_clickableL = false
var double_clickableR = false
var double_click_window = 0.15
var no_turn = false

var coins = 0

signal roundLostSignal
var has_lost = false 

var team: Node
var player_infos
var upgrades_list = []

var situation

func _init():
	pass

func _ready():
#	player_infos = get_node("/root/" + self.get_name())
	pass
	
	
	



func _process(delta):
	
	
	$"BoatHUD/HP".value = $"Boat".hit_points
	$"BoatHUD".position = $Boat.position + Vector2(0, 90)
#	if $"Boat".hit_points == 0:
#		$"BoatHUD".hide()
	
	
	if Input.is_action_just_pressed(RightControl):
		if $"Boat".can_shoot:
			no_turn = true
			timerNoTurn.start()
			if double_clickableR:
				$"Boat".shootRight()
				double_clickableR = false
			
			
	if Input.is_action_just_released(RightControl):
		double_clickableR = true
		timerR.start()
		no_turn = false
		
			
	if Input.is_action_just_pressed(LeftControl):
		if $"Boat".can_shoot:
			no_turn = true
			timerNoTurn.start()
			if double_clickableL:
				$"Boat".shootLeft()
				double_clickableL = false
			
			
	if Input.is_action_just_released(LeftControl):
		double_clickableL = true
		timerL.start()
		no_turn = false
		
		
	if Input.is_action_just_pressed(DownControl):
		specialMove()
		
	#	Rotation process
	var a
	var f
	var S
	
	f = $"Boat".friction
	S = $"Boat".base_rotation_speed
	
	if Input.is_action_just_pressed(LeftControl) && $"Boat".can_move:
		if not no_turn:
			$"Boat".rotation_speed -= S
		
	elif Input.is_action_just_pressed(RightControl) && $"Boat".can_move:
		if not no_turn:
			$"Boat".rotation_speed += S
	
	if Input.is_action_pressed(LeftControl) && $"Boat".can_move:
		
		if no_turn:
			a = 0
		else:
			a = - $"Boat".rotation_acc
			
		
	elif Input.is_action_pressed(RightControl) && $"Boat".can_move:
		
		if no_turn:
			a = 0
		else:
			a = $"Boat".rotation_acc
			
		
	else:
		a = 0
	
	
		
	if $"Boat".rotation_speed >0:
		a -= f
		
	if $"Boat".rotation_speed <0:
		a += f
		
	$"Boat".rotation_speed += a * delta

	
	
func loaded():
#	Move the Boat to it's spawn position given by the Level
	$"Boat".global_position = SpawnPosition
	$"Boat".global_rotation = SpawnRotation
	
	$"Boat".team = player_infos.team
	
	$"Boat".connect("boatSunk", Callable(self, "round_lost"))
	
	self.connect("roundLostSignal", Callable(team, "check_lost"))
	
	update()
	
#	Timer for the double click check
	timerL.connect("timeout", Callable(self, "end_double_clickL"))
	timerL.wait_time = double_click_window
	timerL.one_shot = true
	add_child(timerL)
	
	timerR.connect("timeout", Callable(self, "end_double_clickR"))
	timerR.wait_time = double_click_window
	timerR.one_shot = true
	add_child(timerR)
	
	timerNoTurn.connect("timeout", Callable(self, "end_no_turn"))
	timerNoTurn.wait_time = 0.1
	timerNoTurn.one_shot = true
	add_child(timerNoTurn)

func start():
	$"Boat".can_move = true
	$"Boat".can_shoot = true
	
func unload():
	player_infos.coins += coins
	print(player_infos.coins)
	
	
# Badly named function but it's basicaly called to load the Singleton data into the player
# when they join the level.
func update():
	#Set the base stats based on the singleton provided stats
	#$Boat.hit_points = player_infos.d_hit_points
	#$Boat.speed = player_infos.d_speed
	#$Boat.is_wind_imune = player_infos.d_is_wind_imune
	
	#set up the Special for the game
	if player_infos.specialUpgrades.size() != 0:
		for i in(player_infos.specialUpgrades.size()):
			player_infos.specialUpgrades[i].setup(self)
			
	else: $"Boat/Upgrades/SpecialMove".hide() #hide the special indicator if not used

	#setup each upgrade ie:add their stat boosts to the base stats
	for i in(player_infos.basicUpgrades.size()):
		player_infos.basicUpgrades[i].setup(self)
	
	
	$"Boat/BoatSprite".frames = player_infos.sprite
	
	$BoatHUD/PlayerName.text = player_infos.HUDName
	$BoatHUD/HP.self_modulate = team.team_infos.color
	$BoatHUD/HP.max_value = $Boat.hit_points
	
	LeftControl = player_infos.LeftControl
	RightControl = player_infos.RightControl
	DownControl = player_infos.DownControl
	
	

	
func round_lost():
	has_lost = true
	
	$"BoatHUD".hide()
	
	emit_signal("roundLostSignal")
		



func end_double_clickL():
	double_clickableL = false
	
	
func end_double_clickR():
	double_clickableR = false
	
func end_no_turn():
	no_turn = false


func specialMove():
	if $Boat.can_shoot:
		for i in (player_infos.specialUpgrades.size()):
			player_infos.specialUpgrades[i].start()
