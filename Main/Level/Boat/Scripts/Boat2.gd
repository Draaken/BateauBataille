extends BoatClass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func setup():
	speed_max = 110
	acceleration = 1.0
	var speedfactor = speed_max/100
	reload_time = 4
	hit_points = 3
	#rotation_acc = 5
	#rotation_max = 1.4
	#base_rotation_speed = 0.5
	rotation_acc = 3
	rotation_max = 0.8
	base_rotation_speed = 0.5
	brake_accel = 2.0
	friction = 1.5
	delay = 1
	wind_imunity = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
