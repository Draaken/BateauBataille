extends CanonClass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	canon_ball = preload("res://Main/Level/Boat/Canonball/Scenes/CanonballV2.tscn")
	strength = 500
	dispertion = 5
	boat = null
	
	
func shoot(shooter):
	super(shooter)
	
	#var tween = create_tween()
	
	#tween.tween_property($Light, "energy", 2.0, 0.1)
	#tween.tween_property($Light, "energy", 0, 0.3)
	#$Light.energy = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
