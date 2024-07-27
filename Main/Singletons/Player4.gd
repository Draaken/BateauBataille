extends PlayerInfosClass

var sprite = preload("res://Main/Level/Boat/Ressources/Boat2-2_animation.tres")
var RightControl = "P4Right"
var LeftControl = "P4Left"
var DownControl = "P4Down"
var UpControl = "P4Up"

var is_playing = false
var team:int = 2

var HUDName = "null"

var special = preload("res://Main/Upgrades/Resources/rear_canon.tres").duplicate()


