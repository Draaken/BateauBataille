extends HitableObject
var damage_type = "Planks"
var sound_damage = preload("res://Main/Sounds/Placeholders/boat_hit_shitty.mp3")

func _ready():
	hit_points = 1
	is_destructible = true
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, true)
	set_collision_layer_value(4, false)
	
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, false)
	set_collision_mask_value(4, false)

func take_damage(damage, damage_type):
	super(damage, damage_type)
	
	$AudioStreamPlayer.stream = sound_damage
	$AudioStreamPlayer.play()
	
	
	if hit_points <=0:
		set_collision_layer_value(2, false)
		set_collision_layer_value(3, false)
		self.hide()
		await $AudioStreamPlayer.finished
		self.queue_free()
