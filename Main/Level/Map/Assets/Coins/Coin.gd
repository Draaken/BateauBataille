extends Node2D
#script of the coin spawnpoint
var value = 1
#var is_active = false
var is_moving_to_target = false
var distance_to_target = 0
var speed = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var hitbox = $"HitBox"
	
	hitbox.set_collision_layer_value(1, false)
	hitbox.set_collision_layer_value(2, false)
	hitbox.set_collision_layer_value(3, false)
	hitbox.set_collision_layer_value(4, false)
	
	hitbox.set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(3, false)
	hitbox.set_collision_mask_value(4, true)
	
	
	hitbox.connect("body_entered", Callable(self, "on_pick_up"))
	
	hitbox.monitoring = true
	
	
func _process(delta):
	if is_moving_to_target:
		self.global_position += speed*delta
		

#func activate():
	#self.show()
	#$"HitBox".set_deferred("monitoring", true)
	#$"Sprite2D".play()
	#is_active = true
#
func desactivate():
	#is_active = false
	self.hide()
	self.queue_free()

func on_pick_up(body):
	print("picked up")
	body.pick_up_coin(value)
	#$"../..".spawn()
	self.desactivate()
	
func go_toward(body):
	var direction = global_position.direction_to(body.global_position)
	speed = distance_to_target*1.8 * direction
	if distance_to_target <100:
		speed = 180 * direction
		
	is_moving_to_target = true
	
