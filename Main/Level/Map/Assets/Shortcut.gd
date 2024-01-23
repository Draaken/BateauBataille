extends Area2D
@export var twin_path = ""
var twin
# var a = 2
# var b = "text"
var transformation_vector = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	twin = get_node(twin_path)
	
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, true)
	
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, false)
	
	
	self.connect("body_entered", Callable(self, "entered"))
	
	transformation_vector = Vector2(twin.global_position.x - self.global_position.x, twin.global_position.y - self.global_position.y )
	


func entered(body):
	var loc_rotation = self.global_rotation - body.global_rotation
	print(loc_rotation)
	
	
	var offset = 100 * abs(cos(loc_rotation)) + 50
	var offset_vector = Vector2()
	
	if loc_rotation > -PI/2 && loc_rotation < PI/2:
		pass
	else:
		offset = - offset
	
	offset_vector = Vector2(cos(global_rotation), sin(global_rotation))*offset

	body.global_position += transformation_vector + offset_vector
	


