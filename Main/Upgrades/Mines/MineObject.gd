extends HitableObject


@onready var hitbox = self
#@onready var tool_explosion = $"Explosion"

var explosion = preload("res://Main/Level/Effects/explosion.tscn")

var explosion_lifespan = 0.3
var is_exploding = false

var explosion_radius = 70
var arm_time = 0.1

var damage_type = "Explosion"

func _ready():
	hit_points = 0
	
	
	self.hide()
	#tool_explosion.hide()
	
	hitbox.set_collision_layer_value(1, false)
	hitbox.set_collision_layer_value(2, false)
	hitbox.set_collision_layer_value(3, false)
	hitbox.set_collision_layer_value(4, false)
	
	hitbox.set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(3, false)
	hitbox.set_collision_mask_value(4, false)
	
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = arm_time
	add_child(timer)
	timer.start()
	
	await timer.timeout
	
	arm()
	
func arm():
	self.show()
	hitbox.set_collision_layer_value(2, true)
	hitbox.set_collision_layer_value(3, true)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#if is_exploding:
		#for i in range(body_list.size()-1, -1, -1):
			#if body_list[i].is_destructible:
				#damage_target(i)

func take_damage(damage, damage_type):
	super(damage, damage_type)
	explode()


	


func explode():
	
	is_exploding = true
	
	var instance = explosion.instantiate()
	#instance.radius = explosion_radius
	
	add_child(instance)
	hitbox.set_collision_layer_value(2, false)
	hitbox.set_collision_layer_value(3, false)

	
	await instance.explosion_finished
	is_exploding = false
	self.queue_free()


