extends Node2D

var velocity = Vector2(0,0)
var is_moving = false

func _process(delta):
	if is_moving:
		position += velocity*delta*10
		
		
		if position.y > $"..".map_size.y + 2000 || position.y < - 2000:
			self.queue_free()
		if position.x > $"..".map_size.x + 2000 || position.x < - 2000:
			self.queue_free()
