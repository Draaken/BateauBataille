extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time. 
func _ready():
	await owner.ready
	self.modulate = $"../..".color_patern



func _process(delta):
	
	var wind = $"../..".wind
	global_rotation = atan2(wind.y, wind.x)
