extends Node

var sprite = preload("res://Main/Level/Boat/Ressources/Boat2-1_animation.tres")
var RightControl = "P1Right"
var LeftControl = "P1Left"
var DownControl = "P1Down"

var is_playing:bool = false
var team:int = 2

var HUDName = "null"

var a = preload("res://Main/Upgrades/Resources/HP1.tres").duplicate()

var specialUpgrades = []
var basicUpgrades = []

var hit_points = 3
var coins = 0
var auction_coins = 0

#func _process(delta):
#	print(team)
