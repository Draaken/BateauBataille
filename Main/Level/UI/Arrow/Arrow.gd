extends Node2D


var boat
var map_size
var x_margin = 50
var y_margin = 50

var x_max
var x_min
var y_max
var y_min

# Called when the node enters the scene tree for the first time.
func _ready():
	boat = $"../Boat"
	map_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"),ProjectSettings.get_setting("display/window/size/viewport_height"))
	
	x_max = map_size.x - x_margin
	x_min = x_margin
	
	y_max = map_size.y - y_margin
	y_min = y_margin
	

func _process(_delta):
	
	self.show()
	
	if boat.position.x > map_size.x:
		if boat.position.y > y_max:
			self.position = Vector2(x_max, y_max)
		
		elif boat.position.y < y_min:
			self.position = Vector2(x_max, y_min)
		
		else:
			self.position.x = x_max
			self.position.y = boat.position.y
			

			
	elif boat.position.x < 0:
		if boat.position.y > y_max:
			self.position = Vector2(x_min, y_max)
			
		
		elif boat.position.y < y_min:
			self.position = Vector2(x_min, y_min)
		
		else:
			self.position.x = x_min
			self.position.y = boat.position.y
			
	elif boat.position.y > map_size.y:
		self.position.y = y_max
		self.position.x = boat.position.x
		
	elif boat.position.y < 0:
		self.position.y = y_min
		self.position.x = boat.position.x
	
	else:
		self.hide()
		
	self.look_at(boat.position)
	
		
		
	
