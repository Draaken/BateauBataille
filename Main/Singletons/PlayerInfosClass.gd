extends Node

class_name PlayerInfosClass

var specialUpgrades = []
var basicUpgrades = []

#var d_hit_points
#var d_speed
#var d_is_wind_imune

var coins
var auction_coins

var a = preload("res://Main/Upgrades/Resources/reload1.tres").duplicate()

func reset():
	
	specialUpgrades = []
	basicUpgrades = []
	
	#d_hit_points = 3
	#d_speed = 100
	#d_is_wind_imune = false
	
	coins = 0
	auction_coins = 0
