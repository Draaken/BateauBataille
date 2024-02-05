class_name CanonClass extends Area2D

signal canonball_shooted 

var audio_player = AudioStreamPlayer.new()

var shot = preload("res://Main/Level/Boat/Canon/Scenes/Shot.tscn")

#sounds effects preload
var sound_shout1 = preload("res://Main/Sounds/Placeholders/canon_shout1.mp3")
var sound_shout2 = preload("res://Main/Sounds/Placeholders/canon_shout2.mp3")
var sound_reload = preload("res://Main/Sounds/Placeholders/canon_reload.mp3")

#var shot_position = Vector2()
#var shot_rotation
var boat 
var level
var shot_clone
var is_shooting = false
var canon_orientation
var canon_orientation_vector = Vector2()
var random = RandomNumberGenerator.new()
var reload_timer = Timer.new()
var reload_time = 4

var reload_position = position + Vector2(0,10)
var original_position = position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_reloaded = true


var canon_ball = preload("res://Main/Level/Boat/Canonball/Scenes/CanonballV1.tscn")
var strength = 650
var dispertion = 0


func _ready():
	random.randomize()
	level = get_node("/root/MasterScene/Level")
	self.connect("canonball_shooted", Callable(level, "receive_canonball"))
	reload_timer.one_shot = true
	reload_timer.connect("timeout", Callable(self, "reload"))
	add_child(reload_timer)
	
	
	add_child(audio_player)
	
#func _process(delta):
#	if is_shooting:
#		shot_clone.global_position = shot_position
#		shot_clone.global_rotation = shot_rotation

func shoot(shooter):
	random.randomize()
	var dispertion_range  = deg_to_rad(random.randf_range(-dispertion, dispertion))
	
	canon_orientation = global_rotation - PI/2 + dispertion_range
	canon_orientation_vector = Vector2(cos(canon_orientation), sin(canon_orientation))
	
	var instance = canon_ball.instantiate()
	instance.velocity_norm = strength
	instance.shooter = shooter
	var boat_velocity = Vector2(0,0)
	
	if boat != null:
		boat_velocity = boat.velocity

	emit_signal("canonball_shooted", instance, $"CanonBallSpawn".global_position, canon_orientation_vector, boat_velocity)

	reload_timer.wait_time = reload_time
	reload_timer.start()
	print(reload_time)
#
	match random.randi_range(0,1):
		0:
			audio_player.stream = sound_shout1
		1:
			audio_player.stream = sound_shout2
			
	audio_player.play()

	$"Shot".frame = 0
	$"Shot".play()
		
	is_reloaded = false
	
	$Sprite2D.position.y = reload_position.y
	$Shot.position.y = reload_position.y - 60
		
func reload(): 
	is_reloaded = true
#	self.show()
	audio_player.stream = sound_reload
	audio_player.play()
	$Sprite2D.position.y = original_position.y
	$Shot.position.y = original_position.y
	
#func kill_shot_clone():
#	shot_clone.queue_free()
#	is_shooting = false
