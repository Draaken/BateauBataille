extends CanonballClass


func _ready():
	lifespan = 0.6
	damage = 1
	super() 

func explode(target):
	super(target)
	if is_active:
		if target.has_sail:
			target.speed *= 0.8
			target.rotation
			target.rotation_acc *= 0.9
			target.rotation_max *= 0.9
