@tool
extends HitableObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage_type = "Shore"

# Called when the node enters the scene tree for the first time.
func _init():
	collision_mask = 0
	set_collision_layer_value(2, true)
func _process(delta):
	if $CollisionPolygon2D.get_child_count() != 0:
		$CollisionPolygon2D/Polygon2D.polygon = $CollisionPolygon2D.polygon
		$CollisionPolygon2D/Polygon2D.color = Color(1, 1, 0.941176, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
