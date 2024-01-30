class_name BoatClass extends HitableObject



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

#Parameters
var speed
var reload_time
var is_wind_imune
var base_rotation_speed
var potential_rotation = 0
var rotation_acc
var rotation_max 
var friction
var delay


var former_delay_list = [0]

signal boatSunk
signal rammed

var is_dashing = false
var is_sunk = false
var is_ashore = false
var is_in_wind = false


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
	
	
	velocity += Vector2(cos(rotation)*(speed), sin(rotation)*(speed)) 
	$Label.text = str(int(velocity.length()))

	if can_move:
		var collision = move_and_collide(velocity*delta)
		
		if collision:
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
				
				if not collider.is_destructible:
					self.take_damage(0, collider_type)
					
				emit_signal("rammed")
				
			elif collider.is_destructible : 
				collider.take_damage(0, damage_type)
				
			
	
	
func turn(delta):
	#self.rotation += new_rotation_speed*delta
	potential_rotation += new_rotation_speed*delta
	rotation = snapped(potential_rotation, PI/32)

func shootLeft():
	$"Canons/LeftCanons".shoot(self)


func shootRight():
	$"Canons/RightCanons".shoot(self)
		
		
func check_wind(delta):
	var a = 125
	var wind_velocity_goal = 0
	if is_in_wind:
		var dot_product = wind_zone.wind_force.normalized().dot(old_velocity.normalized())
		wind_velocity_goal = wind_zone.magnitude * (dot_product + 0.2) # the +0.2 is so the boat is less slowed down than accelarated
		
		if is_wind_imune && wind_velocity_goal < 0:
			wind_velocity_goal = 0
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
	
	if hit_points <= 0:
		if damage_type == "Canonball" || damage_type == "Boat" || damage_type == "Explosion":
			sink()
		if damage_type == "Shore" || damage_type == "Rock" || damage_type == "Tree":
			sink()
			
	if damage != 0:
		$Cosmetic/Hit.show()
		$Cosmetic/Hit/Sprite.play()
	

func sink():
	is_sunk = true
	$"Cosmetic".hide()
	can_move = false
	can_shoot = false
	z_index = -10
	
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
