class_name HitableObject extends CharacterBody2D


@export var is_destructible = false
@export var is_movable = false

var team = 0
var pushed_velocity = Vector2(0,0)
var hit_points
var weight = 1
var old_velocity = Vector2(0,0)

func _physics_process(delta):
	check_pushed(delta)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_pushed(force):
	if is_movable:
		pushed_velocity = force
	
func take_damage(damage, damage_type):
	if is_destructible:
		self.hit_points -= damage

func check_pushed(delta):
	if pushed_velocity.length() > 0:
		var a = 600
		pushed_velocity = pushed_velocity.normalized() * (pushed_velocity.length() - (a * delta))
		velocity += pushed_velocity
		
		
	elif pushed_velocity.length() < 0:
		pushed_velocity = Vector2(0,0)
	
