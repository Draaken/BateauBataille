extends Node2D

@onready var cloud_timer = $CloudTimer
var cloud = preload("res://Main/Level/Clouds/cloud.tscn")
var black_cloud = preload("res://Main/Level/Clouds/black_cloud.tscn")


var weather_mode = "Clear"
var wind_velocity = Vector2(5,0)
var velocity_factor = 1.0
var cloud_spawn_factor = 1.0
var wind_direction = 0

var random = RandomNumberGenerator.new()
var map_size

var old_rand_y = 0


func _ready():
	random.randomize()
	
	map_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"),
			ProjectSettings.get_setting("display/window/size/viewport_height"))
	
	while wind_direction == 0:
		wind_direction = randi_range(-1,1)
		print(str(wind_direction)+" wind direction")
		
	#cloud_timer.connect("timeout", Callable(self, "spawn_cloud"))
	cloud_timer.one_shot = true
	
	#randomly choose the weather
	var weather_random = random.randi_range(0,100)
	if weather_random <= 60:
		weather_mode = "Clear"
	elif weather_random <= 90:
		weather_mode = "Cloud"
	elif weather_random <= 100:
		weather_mode = "Storm"
		
	update_weather()
	
func update_weather():
	match weather_mode:
		"Clear":
			$"Storm Filter".hide()
		"Cloud":
			$"Storm Filter".hide()
			var a = random.randfn(0.6,0.4)
			cloud_spawn_factor = clamp(cloud_spawn_factor, 0.0, 2.0)
			
			spawn_cloud(cloud)
		"Storm":
			$"Storm Filter".show()
			cloud_spawn_factor = 1.0
			velocity_factor = random.randfn(1.2, 0.2)
			clamp(velocity_factor, 0.0, 2.0)
			spawn_cloud(black_cloud)
		_:
			pass
			print("The specified weather mode does not exist.")
			

#Loop function that spawn clouds as child to the CloudsGenerator
#The argument is the preload of the intended Node (black or simple clouds)
func spawn_cloud(cloud_type):
	while weather_mode == "Cloud" || weather_mode == "Storm": #double security
		
		var cloud_instance = cloud_type.instantiate()
		add_child(cloud_instance)
		
		var rand_y = randi_range(0, map_size.y)
		while rand_y-old_rand_y < 100 && rand_y-old_rand_y > -100:
			rand_y = randi_range(0, map_size.y)
		old_rand_y = rand_y
		#reroll the random position is two clouds in a row are too close to each others
		
		#normal randomization of the scale
		var rand_scale = randfn(1,0.1) 
		cloud_instance.scale = Vector2(rand_scale, rand_scale) *1.5 
		#the 1.5 is temporary! ReDraw bigger sprites!
		
		#normal randomization of the x velocity around the base velocity. 
		var rand_velocity = randfn(wind_velocity.length(), wind_velocity.length()/8)
		cloud_instance.velocity = Vector2((rand_velocity)*wind_direction, wind_velocity.y)  * velocity_factor
		
		#wind_direction is either 1 or -1, determining if the clouds are going left or right
		match wind_direction:
			1:
				cloud_instance.position = Vector2(-700,rand_y)
			-1:
				cloud_instance.position = Vector2(map_size.x+700,rand_y)
		
		#this whole thing get the number of differents "frames" (ie: sprites) and then
		#choose one randomly to be the next cloud
		var anim_frame_count = cloud_instance.get_node("Sprite").sprite_frames.get_frame_count("default")
		var rand_frame = randi_range(0,anim_frame_count)
		cloud_instance.get_node("Sprite").frame = rand_frame
		
		cloud_instance.is_moving = true
		
		cloud_instance.show()
		
		#determine the spawn time of the next cloud
		var a = random.randfn(0.5, 0.2) - 0.2
		var n_facteur = clamp(a, 0.0, 1.0) #normal distribution factor used to determine the spawn time
		cloud_timer.wait_time = n_facteur / cloud_spawn_factor * 15.0
		#cloud_spawn_factor is a global parameter used to change the average cloud frequency
		
		print(cloud_timer.wait_time)
		cloud_timer.start()
		await cloud_timer.timeout # wait for the cloud_timer end, then loop

		if weather_mode == "Storm": 
			thunder_effect()
	

#generate the flashing ligth effect. That's all.
func thunder_effect():
	var tween = create_tween()
	#$"Storm Filter".hide()
	$"Thunder Filter".energy = 0
	tween.tween_property($"Thunder Filter", "energy", 3.0, 0.05)
	tween.tween_property($"Thunder Filter", "energy", 0.0, 0.3)
	
	
