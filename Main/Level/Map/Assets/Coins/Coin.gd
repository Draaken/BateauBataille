extends Node2D
#script of the coin spawnpoint
var value = 1

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
	
	self.hide()
	hitbox.monitoring = false
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func activate():
	self.show()
	$"HitBox".set_deferred("monitoring", true)
	$"Sprite2D".play()

func desactivate():
	self.hide()
	$"HitBox".set_deferred("monitoring", false)
	$"Sprite2D".stop()
	print("deleted")

func on_pick_up(body):
	print("picked up")
	body.pick_up_coin(value)
	$"../..".respawn()
	self.desactivate()
