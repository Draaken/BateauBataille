extends Node2D
#script of the coin spawnpoint
var value = 1
var is_active = false
var is_moving_to_target = false
var distance_to_target = 0
var speed = 0
var coin = preload("res://Main/Level/Map/Assets/Coins/Coin.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.hide()
	
	
func _process(delta):
	pass
		

func spawn_coin():
	var instance = coin.instantiate()
	instance.global_position = self.global_position
	get_node("../../CoinList").add_child(instance)

