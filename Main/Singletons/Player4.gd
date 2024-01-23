extends Node

var sprite = preload("res://Main/Level/Boat/Ressources/Boat2-2_animation.tres")
var RightControl = "P4Right"
var LeftControl = "P4Left"
var DownControl = "P4Down"

var is_playing = false
var team:int = 1

var HUDName = "null"

var special = preload("res://Main/Upgrades/Resources/rear_canon.tres").duplicate()

var specialUpgrades = []
var basicUpgrades = []

var hit_points = 3

var coins = 0
var auction_coins = 0
