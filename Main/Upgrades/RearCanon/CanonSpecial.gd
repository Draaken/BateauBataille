extends CanonClass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	canon_ball = preload("res://Main/Level/Boat/Canonball/Scenes/CanonballV2.tscn")
	strength = 900
	dispertion = 0
	boat = get_node("../../..")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
