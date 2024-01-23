extends Node2D
var round_lenght = 60

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", Callable(self, "_on_round_end"))
	$Timer.one_shot = true


func _process(delta):
	$CenterContainer/Label.text = str(int($Timer.time_left))

func start():
	$"Timer".wait_time = round_lenght
	$"Timer".one_shot = true
	$"Timer".start()
	
func _on_round_end():
	pass
