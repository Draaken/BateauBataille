extends Node2D

signal startGame
signal backToMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1,5):
		var player = get_node("/root/Player"+str(i))
		var check_box = get_node("VBoxContainer/" + player.get_name() + "/CheckBox")
		var team_button = get_node("VBoxContainer/" + player.get_name() + "/CheckButton")
		
		player_leaves(player)
		
		if player.is_playing:
			check_box.button_pressed = true
			player_joins(player)
		else:
			check_box.button_pressed = false
			
		if player.team == 2:
			team_button.button_pressed = true
		else:
			team_button.button_pressed = false
	
	for i in range (1,5):
		get_node("/root/Team" + str(i)).team_members = []
	

func _process(_delta):
	pass

func start():
	emit_signal("startGame")
	
func back():
	emit_signal("backToMenu")


func joinSwitch(button_pressed, player): 
#function used to detect if a player is playing or not when the button is pressed
	if button_pressed:
		player_joins(get_node("/root/"+player))
	else:
		player_leaves(get_node("/root/"+player))

func player_joins(player):
	player.is_playing = true

	
	#Add player to the list of players
	$"..".players_list.append(player)
	
	#Add player to the team list
	#team_infos is the path to the corresponding team singleton
	var team_infos = get_node("/root/Team"+ str(player.team)) 
	team_infos.team_members.append(player)
	
	
	#Actualise HUDNames of all the players
	for i in range($"..".players_list.size()):
		
		var HUDName = "null"
		var other_player = $"..".players_list[i]
		
		HUDName = "P"+str(i+1)
		other_player.HUDName = HUDName
	
	
#	for i in range(1,5):
#		var cplayer = "Player" + str(i)
#
#		print(cplayer  + ": " + str(get_node("/root/" + cplayer).is_playing))
	
func player_leaves(player):
	if player.is_playing:
		player.is_playing = false
		
		#Remove player from the players list
		for i in range($"..".players_list.size() - 1, -1, -1):
			if $"..".players_list[i] == player:
				$"..".players_list.remove_at(i)
				
		#Remove player from the team list
		#team_infos is the path to the corresponding team singleton
		var team_infos = get_node("/root/Team"+ str(player.team)) 
		for i in range(team_infos.team_members.size() - 1, -1, -1):
			if team_infos.team_members[i] == player:
				team_infos.team_members.remove_at(i)
		
		#Actualise HUDNames of all the players
		for i in range($"..".players_list.size()):
			
			var HUDName = "null"
			var other_player = $"..".players_list[i]
			
			HUDName = "P"+str(i+1)
			other_player.HUDName = HUDName
				
		
	#	for i in range(1,5):
	#		var cplayer = "Player" + str(i)
	#
	#		print(cplayer + ": " + str(get_node("/root/" + cplayer).is_playing))

func teamSwitch(button_pressed, player):
	if button_pressed:
		get_node("/root/"+player).team = 2
	else:
		get_node("/root/"+player).team = 1

