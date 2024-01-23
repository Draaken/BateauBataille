class_name CanonClass extends Area2D

signal canonball_shooted 

var shot = preload("res://Main/Level/Boat/Canon/Scenes/Shot.tscn")

#var shot_position = Vector2()
#var shot_rotation
var boat
var shot_clone
var is_shooting = false
var canon_orientation
var canon_orientation_vector = Vector2()
var random = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_reloaded = true


var canon_ball = preload("res://Main/Level/Boat/Canonball/Scenes/CanonballV1.tscn")
var strength = 650
var dispertion = 5


func _ready():
	self.connect("canonball_shooted", Callable(get_node(boat).get_node(".."), "receive_canonball"))


#func _process(delta):
#	if is_shooting:
#		shot_clone.global_position = shot_position
#		shot_clone.global_rotation = shot_rotation

func shoot():
	random.randomize()
	var dispertion_range  = deg_to_rad(random.randf_range(-dispertion, dispertion))
	
	canon_orientation = global_rotation - PI/2 + dispertion_range
	canon_orientation_vector = Vector2(cos(canon_orientation), sin(canon_orientation))
	
	var instance = canon_ball.instantiate()
	instance.velocity_norm = strength
	

	emit_signal("canonball_shooted", instance, $"CanonBallSpawn".global_position, canon_orientation_vector, get_node(boat).velocity)
	
#	is_shooting = true
#	shot_clone = shot.instance()
#	add_child(shot_clone)
#	shot_clone.connect("animation_finished", self, "kill_shot_clone")
#	shot_clone.frame = 0
#	shot_clone.play()
#	shot_position = shot_clone.global_position
#	shot_rotation = shot_clone.global_rotation
	$"Shot".frame = 0
	$"Shot".play()
		
	is_reloaded = false
#	self.hide()
	$Sprite2D.position.y += 10
	$Shot.position.y += 10
		
func reload(): 
	is_reloaded = true
#	self.show()
	$Sprite2D.position.y -= 10
	$Shot.position.y -= 10
	
#func kill_shot_clone():
#	shot_clone.queue_free()
#	is_shooting = false
