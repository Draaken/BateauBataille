class_name Player extends Node2D

signal specialUsed

@onready var boat = get_node("Boat")

var LeftControl
var RightControl
var DownControl
var UpControl
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
	
	
	$"BoatHUD/HP".value = boat.hit_points
	$"BoatHUD".position = $Boat.position + Vector2(0, 90)
#	if boat.hit_points == 0:
#		$"BoatHUD".hide()
	
	
	if Input.is_action_just_pressed(RightControl):
		if boat.can_shoot:
			no_turn = true
			timerNoTurn.start()
			if double_clickableR:
				boat.shootRight()
				double_clickableR = false
			
			
	if Input.is_action_just_released(RightControl):
		double_clickableR = true
		timerR.start()
		no_turn = false
		
			
	if Input.is_action_just_pressed(LeftControl):
		if boat.can_shoot:
			no_turn = true
			timerNoTurn.start()
			if double_clickableL:
				boat.shootLeft()
				double_clickableL = false
			
			
	if Input.is_action_just_released(LeftControl):
		double_clickableL = true
		timerL.start()
		no_turn = false
		
		
	if Input.is_action_pressed(DownControl):
		#specialMove()
		boat.brake(delta)
	
	if Input.is_action_just_pressed(UpControl):
		specialMove()
		
	#	Rotation process
	var a
	var f
	var S
	
	f = boat.friction
	S = boat.base_rotation_speed
	
	if Input.is_action_just_pressed(LeftControl) && boat.can_move:
		if not no_turn:
			boat.rotation_speed -= S * delta * 60
		
	elif Input.is_action_just_pressed(RightControl) && boat.can_move:
		if not no_turn:
			boat.rotation_speed += S * delta * 60
	
	if Input.is_action_pressed(LeftControl) && boat.can_move:
		
		if no_turn:
			a = 0
		else:
			a = - boat.rotation_acc * delta * 60
			
		
	elif Input.is_action_pressed(RightControl) && boat.can_move:
		
		if no_turn:
			a = 0
		else:
			a = boat.rotation_acc * delta * 60
			
		
	else:
		a = 0
	
	
		
	if boat.rotation_speed >0:
		a -= f
		
	if boat.rotation_speed <0:
		a += f
		
	boat.rotation_speed += a * delta


	
	
func loaded():
#	Move the Boat to it's spawn position given by the Level
	boat.global_position = SpawnPosition
	boat.global_rotation = SpawnRotation
	
	boat.team = player_infos.team
	
	boat.connect("boatSunk", Callable(self, "round_lost"))
	
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
	boat.can_move = true
	boat.can_shoot = true
	
func unload(_team):
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

	for i in(player_infos.canonBallUpgrades.size()):
		player_infos.canonBallUpgrades[i].setup(self)

	#setup each upgrade ie:add their stat boosts to the base stats
	for i in(player_infos.basicUpgrades.size()):
		player_infos.basicUpgrades[i].setup(self)
		
	
	
	$Boat.update()
	
	
	$"Boat/BoatSprite".frames = player_infos.sprite
	
	$BoatHUD/PlayerName.text = player_infos.HUDName
	$BoatHUD/HP.self_modulate = team.team_infos.color
	$BoatHUD/HP.max_value = $Boat.hit_points
	
	LeftControl = player_infos.LeftControl
	RightControl = player_infos.RightControl
	DownControl = player_infos.DownControl
	UpControl = player_infos.UpControl
	
	

	
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
