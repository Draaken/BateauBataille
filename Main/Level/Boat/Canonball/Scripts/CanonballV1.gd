extends CanonballClass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	lifespan = 1
	random.randomize()
	damage = random.randi_range(1,4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
