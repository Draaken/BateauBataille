class_name CanonBoard extends Node2D

var timerReload = Timer.new()
var reload_progress = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func update():
	for i in range(get_child_count()):
		var child = get_node(str(i+1))
		child.update()
	
func _process(delta):
	#reload(delta)
	pass

func shoot(shooter, override = false):
	for i in range(get_child_count()):
		var child = get_node(str(i+1))
		
		if child.is_reloaded || override: 
			var canon_ball:CanonballClass = child.shoot(shooter)
			reload_progress = 0
			return(true)
		else:
			return(false)

	

#func reload(delta):
	#reload_time = $"../..".reload_time * 100
	#
	#reload_progress += 100 * delta
	#if reload_progress >= reload_time:
		#reload_progress = 0
	#
		#for i in range(get_child_count()):
			#var child = get_node(str(i+1))
			
			
			#if child.is_reloaded == false:
				#child.reload()
				#break
				
			
		
	
		
		
 


