extends Node

var sprite = preload("res://Main/Level/Boat/Ressources/Boat2-2_animation.tres")
var RightControl = "P3Right"
var LeftControl = "P3Left"
var DownControl = "P3Down"
	
var is_playing = false
var team:int = 1

var HUDName = "null"
	
var specialUpgrades = []
var basicUpgrades = []
	
var hit_points = 3

var coins = 0
var auction_coins = 0