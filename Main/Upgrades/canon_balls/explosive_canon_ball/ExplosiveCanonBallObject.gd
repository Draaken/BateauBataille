extends CanonballClass

var explosion = preload("res://Main/Level/Effects/explosion.tscn")
var explosion_radius = 30

func _ready():
	lifespan = 0.45
	damage = 0
	super() 

func explode(target):
	if is_active:
		var instance = explosion.instantiate()
		instance.radius = explosion_radius
		add_child(instance)
	super(target)
	
func splash():
	if is_active:
		var instance = explosion.instantiate()
		instance.radius = explosion_radius
		add_child(instance)
	super()
