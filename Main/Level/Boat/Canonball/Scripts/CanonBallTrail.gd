extends Line2D


var lenght = 2
var point = Vector2()
func _ready():
	pass



func _physics_process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = get_parent().global_position
	add_point(point)

		
#	while get_point_count()>lenght:
#		remove_point(0)
	pass
