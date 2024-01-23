extends HitableObject

var body_list = []

@onready var hitbox = self
@onready var explosion = $"Explosion"

var timerExplosion = Timer.new()
var explosion_lifespan = 0.4
var is_exploding = false

var arm_time = 0.1

var damage_type = "Explosion"

func _ready():
	
	timerExplosion.wait_time = explosion_lifespan
	timerExplosion.one_shot = true
	add_child(timerExplosion)
	
	self.hide()
	explosion.hide()
	
	hitbox.set_collision_layer_value(1, false)
	hitbox.set_collision_layer_value(2, false)
	hitbox.set_collision_layer_value(3, false)
	hitbox.set_collision_layer_value(4, false)
	
	hitbox.set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(3, false)
	hitbox.set_collision_mask_value(4, false)
	
	
	explosion.set_collision_layer_value(1, false)
	explosion.set_collision_layer_value(2, true)
	explosion.set_collision_layer_value(3, true)
	explosion.set_collision_layer_value(4, false)
	
	explosion.set_collision_mask_value(1, false)
	explosion.set_collision_mask_value(2, true)
	explosion.set_collision_mask_value(3, true)
	explosion.set_collision_mask_value(4, false)
	
	
	explosion.connect("body_entered", Callable(self, "_on_body_entered"))
	explosion.connect("body_exited", Callable(self, "_on_body_exited"))
	
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
func _process(delta):
	if is_exploding:
		for i in range(body_list.size()-1, -1, -1):
			if body_list[i].is_destructible:
				damage_target(i)

func take_damage(damage, damage_type):
	explode()

func damage_target(i):
	var target = body_list[i]
	if target.damage_type == "Explosion":
		await get_tree().create_timer(0.08).timeout
					
	target.take_damage(1,damage_type)
	body_list.remove_at(i)


func explode():
	explosion.show()
	is_exploding = true
	timerExplosion.start()

	hitbox.set_collision_layer_value(2, false)
	hitbox.set_collision_layer_value(3, false)

	
	await timerExplosion.timeout
	
	explosion.hide()
	is_exploding = false
	self.queue_free()

func _on_body_entered(body):
	body_list.append(body)
	
func _on_body_exited(body):
	for i in range(body_list.size() - 1, -1, -1):
		if body_list[i] == body:
			body_list.remove_at(i)
