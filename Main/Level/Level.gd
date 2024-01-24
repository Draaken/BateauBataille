extends Node2D

var player = preload("res://Main/Level/Players/Player.tscn")

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

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	
	
	
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
	
	await get_tree().create_timer(2).timeout
	
	start_game()
	
#	map.hide()
	

func _process(delta):
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
	
func start_game():
	emit_signal("roundStart")
#	for i in (players_list.size()-1):
#		players_list[i].SpawnPosition = (map.get_node("Starting Positions/" + spawn_position)).position
#		players_list[i].SpawnRotation = (map.get_node("Starting Positions/" + spawn_position)).rotation
func finish_round():
#	for i in range(1,5):
#		get_node("Team"+str(i))
	emit_signal("roundFinished")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
