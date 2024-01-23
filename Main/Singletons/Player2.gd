extends Node

var sprite = preload("res://Main/Level/Boat/Ressources/Boat2-1_animation.tres")
var RightControl = "P2Right"
var LeftControl = "P2Left"
var DownControl = "P2Down"

var is_playing = false
var team:int = 2

var HUDName = "null"

var specialUpgrades = []
var basicUpgrades = []

var hit_points = 3
var coins = 0
var auction_coins = 0
