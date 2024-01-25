extends Node


var coins = 0
var team_members = []
var color = Color(0.9,0.0,0.5,1)

var wins = 0: set = _set_wins 
var old_wins = 0

func _set_wins(new_value):
	old_wins = wins
	wins = new_value
