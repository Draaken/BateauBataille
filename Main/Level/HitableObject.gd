class_name HitableObject extends CharacterBody2D


@export var is_destructible = false
@export var is_movable = false
var hit_points
var weight = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_pushed(force):
	pass
	
func take_damage(damage, damage_type):
	if is_destructible:
		self.hit_points -= damage
