class_name BoatClass extends HitableObject


var sound_coin = preload("res://Main/Sounds/Placeholders/coin_pickup.mp3")
var sound_damage = preload("res://Main/Sounds/Placeholders/boat_hit_shitty.mp3")
var sound_sink = preload("res://Main/Sounds/Placeholders/ship_sink.mp3")
var sound_shore1 = preload("res://Main/Sounds/Placeholders/boat_shore1.mp3")
var sound_shore2 = preload("res://Main/Sounds/Placeholders/boat_shore2.mp3")
var sound_shore3 = preload("res://Main/Sounds/Placeholders/boat_shore3.mp3")
#var timerReload = Timer.new()

var new_rotation_speed
var rotation_speed = 0
var speed_mod = 0
var wind_velocity = 0
var wind_velocity_acc = 0
var boost_velocity = 0
var boost_velocity_acc = 0
var boost_velocity_goal = 0
var boost
var ram_damage = 0
var canon_strength_modifier = 0
var special_cooldown_modifier = 0
var special_cooldown_multiplier = 1

var canon_ball = preload("res://Main/Level/Boat/Canonball/Scenes/CanonballV2.tscn")

#Parameters
var acceleration = 0
var speed = 0
var speed_max
var reload_time
var wind_imunity = 0
var base_rotation_speed
var rotation_acc
var rotation_max 
var friction
var delay
var brake_accel


var former_delay_list = [0]

signal boatSunk
signal rammed
signal shot
signal canon_ball_spawned
signal has_been_hit

var is_dashing = false
var is_sunk = false
var is_ashore = false
var is_in_wind = false
var is_invisible = false


var wind_zone = null
var can_move
var can_shoot

var wind
var color_patern 

var damage_type = "Boat"
#@export_enum("Dash", "RearCanon", "Mines") var special: String = "Dash"


func _init():
	is_destructible = true
	is_movable = true
	has_sail = true
	
		
	former_delay_list.append(0)
	
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, true)
	set_collision_layer_value(4, true)
	
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(4, true)


	can_move = false
	can_shoot = false
	
	
	
	
	setup()
#	timerReload.wait_time = reload_time
#	timerReload.one_shot = true
#	add_child(timerReload)

func setup():
	pass

func _ready():
	pass
	
func update():
	$Canons/RightCanons.update()
	$Canons/LeftCanons.update()

func _process(delta):
#	print(hit_points)

#	if rotation_speed < 0:
#		rotation_speed += inertia
#	if rotation_speed > 0:
#		rotation_speed -= inertia
	
	
	
	if rotation_speed >= rotation_max:
		rotation_speed = rotation_max

	if rotation_speed <= -rotation_max:
		rotation_speed = -rotation_max

	var delay_list = []
	for i in delay:
		delay_list.append(0)
		if i < delay: 
			delay_list[i-1] = former_delay_list[i]
#
#
	delay_list [delay-1] = rotation_speed

	new_rotation_speed = delay_list[0]
#
	former_delay_list = delay_list

	




	turn(delta)
	
func _physics_process(delta):
	old_velocity = velocity
	velocity = Vector2(0,0)
	super(delta)
	check_wind(delta)
	check_boost(delta)
	
	speed += acceleration *delta *60
	speed = clamp(speed, 0, speed_max)
	
	velocity += Vector2(cos(rotation)*(speed), sin(rotation)*(speed)) 
	$Label.text = str(int(velocity.length()))

	if can_move:
		var collision = move_and_collide(velocity*delta)
		
		if collision:
			speed -= 7*acceleration * delta * 60
			var collider = collision.get_collider()
#			var c_velocity = collision.collider_velocity
#			var collision_angle = collision.get_angle()
#			print(collision_angle)
			var collider_type = collider.damage_type
			
			
#			self.take_damage(0, collider_type)
			if is_dashing:
				if collider.is_movable:
					collider.get_pushed(velocity)
				
				if collider.is_destructible:
					collider.take_damage(ram_damage, damage_type)
				
					
				emit_signal("rammed")
				
			elif collider.is_destructible : 
				collider.take_damage(0, damage_type)
				
			if not collider.is_destructible:
					self.take_damage(0, collider_type)
	
func turn(delta):
	self.rotation += new_rotation_speed*delta

func brake(delta):
	speed -= brake_accel*delta*60

func shootLeft(override = false):
	if can_shoot:
		var succeeded = $"Canons/LeftCanons".shoot(self, override)
		if succeeded:
			emit_signal("shot", "left", canon_ball)


func shootRight(override = false):
	if can_shoot:
		var succeeded = $"Canons/RightCanons".shoot(self, override)
		if succeeded :
			emit_signal("shot", "right", canon_ball)
			
func canonball_shooted(instance,position, canon_orientation_vector, boat_velocity):
	emit_signal("canon_ball_spawned", instance)
		
func check_wind(delta):
	var a = 125
	var wind_velocity_goal = 0
	if is_in_wind:
		var dot_product = wind_zone.wind_force.normalized().dot(old_velocity.normalized())
		wind_velocity_goal = wind_zone.magnitude * (dot_product + 0.2) # the +0.2 is so the boat is less slowed down than accelarated
		
		#wind imunity between 0 and 1 reduce the negative effect of wind, over 1 it also boost the positive effect
		if wind_velocity_goal < 0 && wind_imunity!=0 :
			wind_velocity_goal *= clamp(1-wind_imunity,0,1)
		if wind_velocity_goal > 0 && wind_imunity >1 :
			wind_velocity_goal *= wind_imunity
	else:
		wind_velocity_goal = 0
		
	if wind_velocity <= wind_velocity_goal+2*a*delta && wind_velocity >= wind_velocity_goal-2*a*delta:
		wind_velocity = wind_velocity_goal
		wind_velocity_acc = 0
	elif wind_velocity < wind_velocity_goal:
		wind_velocity_acc = a
	else:
		wind_velocity_acc = -a * 0.4
	
	wind_velocity += wind_velocity_acc * delta
	velocity += Vector2(cos(rotation)*wind_velocity, sin(rotation)*wind_velocity) 
	
	
func check_boost(delta):
	if boost_velocity != boost_velocity_goal:
		
		if boost_velocity <= boost_velocity_goal*1.1 && boost_velocity >= boost_velocity_goal*0.9:
			boost_velocity = boost_velocity_goal
			boost_velocity_acc = 0
			
		elif boost_velocity < boost_velocity_goal:
			boost_velocity_acc = +boost

		else:
			boost_velocity_acc = -boost
	
	boost_velocity += boost_velocity_acc * delta
	velocity += Vector2(cos(rotation)*boost_velocity, sin(rotation)*boost_velocity) 
	
func take_damage(damage, damage_type):
	super(damage, damage_type)
	
	emit_signal("has_been_hit")
	
	if hit_points <= 0:
		if damage_type == "Canonball" || damage_type == "Boat" || damage_type == "Explosion":
			sink()
		if damage_type == "Shore" || damage_type == "Rock" || damage_type == "Tree" || damage_type == "Planks":
			sink()
			
	if damage != 0:
		$Cosmetic/Hit.show()
		$Cosmetic/Hit/Sprite.play()
		
		if hit_points > 0:
			$AudioStreamPlayer.stream = sound_damage
			$AudioStreamPlayer.play()
			
		
		
		
	

func sink():
	is_sunk = true
	$"Cosmetic".hide()
	can_move = false
	can_shoot = false
	z_index = -10
	
	$AudioStreamPlayer.stream = sound_sink
	$AudioStreamPlayer.volume_db = 7
	$AudioStreamPlayer.play()
	
	emit_signal("boatSunk")
	
	set_collision_layer_value(2, false)
	set_collision_layer_value(3, false)
	set_collision_layer_value(4, false)
	
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, false)
	set_collision_mask_value(4, false)
	
func ashore():
	hit_points = 10
	is_ashore = true
	can_move = false
	can_shoot = false
	

	
func pick_up_coin(value):
	$"..".coins += value
	$"AudioStreamPlayer".stream = sound_coin
	$"AudioStreamPlayer".play()
