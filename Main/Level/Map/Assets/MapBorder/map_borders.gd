extends Area2D

var wind_force = Vector2(0,0)
@export var deg_direction = 0
var direction = 0
@export var magnitude = 70

func _ready():
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)
	set_collision_layer_value(3, false)
	set_collision_layer_value(4, true)
	
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, false)
	set_collision_mask_value(4, true)
	
	self.connect("body_entered", Callable(self, "_on_entrance"))
	self.connect("body_exited", Callable(self, "_on_exit"))


func _process(delta):
	pass

func _on_entrance(body):
	body.is_in_wind = true
	body.wind_zone = self
	print('in')

func _on_exit(body):
	body.is_in_wind = false
	body.wind_zone = null
	print('out')
