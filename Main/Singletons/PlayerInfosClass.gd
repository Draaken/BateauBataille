extends Node

class_name PlayerInfosClass

var specialUpgrades = []
var basicUpgrades = []
var canonBallUpgrades = []

#var d_hit_points
#var d_speed
#var d_is_wind_imune

var coins
var auction_coins

var a = preload("res://Main/Upgrades/Resources/explosive_canon_ball.tres").duplicate()
var b = preload("res://Main/Upgrades/Resources/double_shot.tres").duplicate()
var d = preload("res://Main/Upgrades/Resources/experimental_gun_powder1.tres").duplicate()

func reset():
	specialUpgrades = []
	basicUpgrades = []
	canonBallUpgrades = []
	
	#d_hit_points = 3
	#d_speed = 100
	#d_is_wind_imune = false
	
	coins = 0
	auction_coins = 0
