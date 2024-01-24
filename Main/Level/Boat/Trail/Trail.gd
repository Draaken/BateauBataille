extends Node2D





func _physics_process(_delta):
	var boat_speed = ($"../../..".velocity.length())
#	$"Particles2D".process_material.scale = 1.5 * boat_speed/100
	
#	if boat_speed == 0:
#		print("ploup")
#		$"Particles2D".emitting = false
	pass
