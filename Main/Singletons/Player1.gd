extends PlayerInfosClass

var sprite = preload("res://Main/Level/Boat/Ressources/Boat2-1_animation.tres")
var RightControl = "P1Right"
var LeftControl = "P1Left"
var DownControl = "P1Down"
var UpControl = "P1Up"

var is_playing:bool = false
var team:int = 1

var HUDName = "null"






#func _process(delta):
#	print(team)
