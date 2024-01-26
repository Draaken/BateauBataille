extends BoatClass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func setup():
	speed = 100
	var speedfactor= speed/100
	reload_time = 4
	hit_points = 3
	rotation_acc = 5
	rotation_max = 1.4
	base_rotation_speed = 0.5
	friction = 1.5
	delay = 1
	is_wind_imune = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
