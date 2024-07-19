extends Node2D

var team_infos
var children_list = []
var alive_players = []
var other_team


func _ready():
	#team_infos is the singleton of the corresponding team
	team_infos = get_node("/root/" + self.get_name())
	alive_players = children_list
	
	match self.get_name():
		"Team1":
			other_team = get_node("../Team2")
		"Team2":
			other_team = get_node("../Team1")
		_:
			print_debug("Invalid Team")
		

func _process(_delta):
	var temp_coins = 0
	for i in range (team_infos.team_members.size()):
		temp_coins += team_infos.team_members[i].coins
#	coins = temp_coins
#	$"Node2D/Coins".text = str(coins)

#Called by the Player whe they die, to check if every player of the team is dead. If so the team loses
func check_lost():
	
	for i in (children_list.size()):
		#print(team_infos.team_members[i].has_lost)
		if children_list[i].has_lost:
			for y in range (alive_players.size() -1, -1, -1):
				if alive_players[y] == children_list[i]:
					alive_players.remove_at(y)
			
	if alive_players == []:
		lost()
		
func lost():
	other_team.win()
	$"..".finish_round(other_team)
	team_infos.wins = team_infos.wins
	
func win():
	team_infos.wins += 1
	
