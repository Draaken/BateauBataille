extends Node2D

@onready var timer = $Timer
var cloud = preload("res://Main/Level/Clouds/cloud.tscn")
var wind_speed = Vector2(3,0)
var wind_direction = 0

var random = RandomNumberGenerator.new()
var map_size

var old_rand_y = 0


func _ready():
	map_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"),ProjectSettings.get_setting("display/window/size/viewport_height"))
	
	while wind_direction == 0:
		wind_direction = randi_range(-1,1)
		print(str(wind_direction)+"wind direction")
		
	timer.connect("timeout", Callable(self, "spawn_cloud"))
	timer.one_shot = true
	spawn_cloud()
	
func set_timer():
	var a = random.randfn(0.5, 0.2) - 0.2
	var n_facteur = clamp(a, 0.0, 1.0)
	timer.wait_time = n_facteur * 15.0
	timer.start()
	print(timer.wait_time)

func spawn_cloud():
	var cloud_instance = cloud.instantiate()
	add_child(cloud_instance)
	
	var rand_y = randi_range(0, map_size.y)
	while rand_y-old_rand_y < 100 && rand_y-old_rand_y > -100:
		rand_y = randi_range(0, map_size.y)
	old_rand_y = rand_y
	
	var rand_scale = randfn(1,0.1)
	var rand_velocity = randfn(wind_speed.length(), wind_speed.length()/10)
	var rand_frame = randi_range(0,3)
	
	match wind_direction:
		1:
			cloud_instance.position = Vector2(-700,rand_y)
		-1:
			cloud_instance.position = Vector2(map_size.x+700,rand_y)
		
	cloud_instance.scale = Vector2(rand_scale, rand_scale) *1.5
	cloud_instance.get_node("Sprite").frame = rand_frame
	
	cloud_instance.is_moving = true
	cloud_instance.velocity = Vector2((wind_speed.x + rand_velocity)*wind_direction, wind_speed.y)
	cloud_instance.show()
	
	set_timer()
	
