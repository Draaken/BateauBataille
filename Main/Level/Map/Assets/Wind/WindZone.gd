@tool
extends Node2D

var random = RandomNumberGenerator.new()

var wind_force = Vector2(0,0)
var direction = 0
var magnitude = 70.0
@export var magnitude_factor = 1.0
@export var deg_direction = 0
@export var random_direction : bool = true
@export var random_sens : bool = true

func _ready():
	var hitbox = $"HitBox"
	
	hitbox.set_collision_layer_value(1, false)
	hitbox.set_collision_layer_value(2, false)
	hitbox.set_collision_layer_value(3, false)
	hitbox.set_collision_layer_value(4, true)
	
	hitbox.set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(3, false)
	hitbox.set_collision_mask_value(4, true)
	
	hitbox.connect("body_entered", Callable(self, "_on_entrance"))
	hitbox.connect("body_exited", Callable(self, "_on_exit"))
	
	if not Engine.is_editor_hint():
		$HitBox/CollisionShape2D/Polygon2D.polygon = $HitBox/CollisionShape2D.polygon
	
	randomize_wind()
	
	
	for i in range($Arrows.get_child_count()):
		var node = get_node("Arrows/" + str(i+1))
		node.rotation = direction + deg_to_rad(+90)
		node.play()
		
		var random_frame = randi_range(0,node.sprite_frames.get_frame_count("default"))
		node.frame = random_frame
		
	$Particles.process_material.angle_max = rad_to_deg(direction) -90
	$Particles.process_material.angle_min = rad_to_deg(direction) -90


func _process(_delta):
	
	if Engine.is_editor_hint():
		for i in range($Arrows.get_child_count()):
			get_node("Arrows/" + str(i+1)).rotation = deg_to_rad(deg_direction-90)
	
	wind_force = Vector2(cos(direction)*magnitude, sin(direction)*magnitude)
	#create a vector from the magnitude and the direction of the wind

func randomize_wind(): 
	if random_direction: #choose a random direction for the wind
		random.randomize()
		direction = random.randf_range(0,2)*PI
	else:
		direction = deg_to_rad(deg_direction)
		
	if random_sens: #choose a random sens for the wind (ie: invert a directed wind)
		if random.randf_range(0,1) > 0.5:
			direction += PI
	
	#add a small variation to the direction
	var variation = random.randf_range(-0.1,0.1)*PI
	direction += variation
	
	magnitude *= magnitude_factor

func _on_entrance(body):
	
	body.is_in_wind = true
	body.wind_zone = self
	
	var tween = get_tree().create_tween()
	$AudioStreamPlayer.playing = true
	$AudioStreamPlayer.volume_db = -20
	tween.tween_property($AudioStreamPlayer, "volume_db", -8, 1)

func _on_exit(body):
	
	body.is_in_wind = false
	body.wind_zone = null
	var tween = get_tree().create_tween()
	tween.tween_property($AudioStreamPlayer, "volume_db", -20, 1)
	
	$AudioStreamPlayer.playing = false
