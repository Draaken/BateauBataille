extends Node

class_name TeamInfosClass


var team_members = []

var coins

var wins: set = _set_wins 
var old_wins

func _set_wins(new_value):
	old_wins = wins
	wins = new_value

func reset():
	wins = 0
	old_wins = 0
	coins = 0
