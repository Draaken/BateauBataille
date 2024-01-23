extends BoatClass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	speed = 80
	reload_time = 1
	hit_points = 20
	rotation_acc = 0.02
	rotation_max = 0.5
	friction = 0.008
	delay = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
