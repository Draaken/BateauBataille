@tool
extends HitableObject


# Declare member variables here. Examples:
# var a = 2
var damage_type = "Tree"


# Called when the node enters the scene tree for the first time.
func _init():
	collision_mask = 0
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, true)

func _process(delta):
	if $CollisionPolygon2D.get_child_count() != 0:
		for i in range(0, get_child_count()):
			if i == 0:
				$CollisionPolygon2D/Polygon2D.polygon = $CollisionPolygon2D.polygon
				$CollisionPolygon2D/Polygon2D.color = Color(0.133333, 0.545098, 0.133333, 1)
			else:
				get_node("CollisionPolygon2D"+ str(i+1) + "/Polygon2D").polygon = get_node("CollisionPolygon2D"+ str(i+1)).polygon
				get_node("CollisionPolygon2D"+ str(i+1) + "/Polygon2D").color = Color(0.133333, 0.545098, 0.133333, 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
