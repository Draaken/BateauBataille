extends Area2D
var radius = 70
var lifespan = 0.3
var decay_time = 0.1

var body_list = []

signal explosion_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$Radius.shape.radius = radius
	var sprite_scale_factor = radius/70.0
	$Sprite.scale = Vector2(sprite_scale_factor, sprite_scale_factor)
	
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, true)
	set_collision_layer_value(4, false)
	
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(4, false)
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	#connect("body_exited", Callable(self, "_on_body_exited"))
	
	get_node("/root/MasterScene/Level/Camera2D").shake(radius/2000.0, 0.1	)
	
	var timerExplosion = Timer.new()
	timerExplosion.wait_time = lifespan
	timerExplosion.one_shot = true
	add_child(timerExplosion)
	timerExplosion.start()
	await timerExplosion.timeout
	
	emit_signal("explosion_finished")
	set_collision_layer_value(2, false)
	set_collision_layer_value(3, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, false)
	
	await get_tree().create_timer(decay_time).timeout
	
	self.queue_free()
	
func damage_target(target):
	#var target = body_list[i]
	#body_list.remove_at(i)
	
	#wait a little bit if the target is antoher explosive in order to have a nice chain effect
	if target.damage_type == "Explosion":
		await get_tree().create_timer(0.08).timeout
					
	target.take_damage(1,"Explosion")


func _on_body_entered(body):
	#body_list.append(body)
	damage_target(body)
	print(body)
	print(self)
	
	
#func _on_body_exited(body):
	#for i in range(body_list.size() - 1, -1, -1):
		#if body_list[i] == body:
			#body_list.remove_at(i)
