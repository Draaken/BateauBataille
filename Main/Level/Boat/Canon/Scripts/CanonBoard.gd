class_name CanonBoard extends Node2D

var timerReload = Timer.new()
var reload_progress = 0
var reload_time 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	reload(delta)

func shoot(shooter):
	for i in range(get_child_count()):
		var child = get_node(str(i+1))
		print(child.is_reloaded)
		
		if child.is_reloaded: 
			child.shoot(shooter)
			reload_progress = 0

		

	

func reload(delta):
	reload_time = $"../..".reload_time * 100
	
	reload_progress += 100 * delta
	if reload_progress >= reload_time:
		reload_progress = 0
	
		for i in range(get_child_count()):
			var child = get_node(str(i+1))
			
			
			if child.is_reloaded == false:
				child.reload()
				break
				
			
		
	
		
		
 


