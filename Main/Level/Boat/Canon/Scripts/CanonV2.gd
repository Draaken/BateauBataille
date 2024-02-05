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
	reload_time = boat.reload_time
	
	
	
	
	
func shoot(shooter):
	reload_time = boat.reload_time
	super(shooter)
	
	
	
	#tween.tween_property($Light, "energy", 2.0, 0.1)
	#tween.tween_property($Light, "energy", 0, 0.3)
	#$Light.energy = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
