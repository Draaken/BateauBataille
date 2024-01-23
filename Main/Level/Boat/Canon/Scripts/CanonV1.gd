extends CanonClass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	canon_ball = preload("res://Boat/Canonball/Scenes/CanonballV1.tscn")
	strength = 650
	dispertion = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
