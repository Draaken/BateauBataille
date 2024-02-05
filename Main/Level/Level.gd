extends Node2D

var player = preload("res://Main/Level/Players/Player.tscn")
var sound_bell = preload("res://Main/Sounds/Placeholders/double_bell.mp3")

#var player1 = preload("res://Players/Player1.tscn")
#var player2 = preload("res://Players/Player2.tscn")
#var player3 = preload("res://Players/Player3.tscn")
#var player4 = preload("res://Players/Player4.tscn")



var map

signal playersLoaded
signal roundStart

signal roundFinished
signal roundCancelled


var wind = Vector2(1,0)



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():


	
	
	
	if get_node("/root/Player1").is_playing:
		load_player("Player1", "P1")
		
	if get_node("/root/Player2").is_playing:
		load_player("Player2", "P2")
		
	if get_node("/root/Player3").is_playing:
		load_player("Player3", "P3")
		
	if get_node("/root/Player4").is_playing:
		load_player("Player4", "P4")
		

	emit_signal("playersLoaded")
	connect("roundStart", Callable($"RoundTimer", "start"))
	
	await get_tree().create_timer(1.5).timeout
	
	$AudioStreamPlayer.stream = sound_bell
	$AudioStreamPlayer.play()
	
	await get_tree().create_timer(0.5).timeout
	
	start_game()
	
#	map.hide()
	

func _process(_delta):
	if Input.is_action_just_pressed("Reload"):
		emit_signal("roundCancelled")

	
	
func load_player(playerName, spawn_position):
	var instance = player.instantiate()
	var team 
#	var team = "Team1"
	
	add_child(instance)
	
	instance.player_infos = get_node("/root/" + playerName)
	team = "Team"+ str(instance.player_infos.team)
	instance.reparent(get_node(team))
	
	
	
	instance.team = get_node(team)
#	instance.player_infos.HUDName = "P" + str(players_list.size())
	
	
	print(team)
	print(get_node(team).team_infos)
	#get_node(team).team_infos.team_members.append(instance)
	
	instance.SpawnPosition = (map.get_node("Starting Positions/" + spawn_position)).position
	instance.SpawnRotation = (map.get_node("Starting Positions/" + spawn_position)).rotation
	instance.situation = "in_level"
	
#	get_node(team).add_child(instance)
	
	
	connect("roundFinished", Callable(instance, "unload"))
	connect("playersLoaded", Callable(instance, "loaded"))
	connect("roundStart", Callable(instance, "start"))
	
	
func receive_canonball(instance, spawn_position, direction, boat_velocity : Vector2 = Vector2(0,0)):
	add_child(instance)
	instance.position = spawn_position
	instance.rotation = atan2(direction.y, direction.x)

#give the canonball it's velocity from the canon, and the initial velocity from the boat
	instance.velocity = (direction * instance.velocity_norm)
	instance.initial_velocity = boat_velocity
	
func receive_mine(instance, spawn_position, spawn_rotation, arm_time):
	instance.global_position = spawn_position
	instance.rotation = spawn_rotation
	instance.arm_time = arm_time
	add_child(instance)
	
	
func start_game():
	emit_signal("roundStart")
	
	
	
#	
func finish_round():
#	for i in range(1,5):
#		get_node("Team"+str(i))
	emit_signal("roundFinished")
	
	
