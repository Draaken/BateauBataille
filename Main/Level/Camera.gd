extends Camera2D
var random = RandomNumberGenerator.new()
var shake_factor = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	make_current()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shake(intensity, delay):
	var number_of_shake = 1
	await get_tree().create_timer(delay).timeout
	
	while intensity > 0.00006:
		var shake_goal = 1 + intensity * random.randfn(1.0,0.3) * shake_factor
		var length = 0.04 + intensity/2.0
		var tween = get_tree().create_tween()
		tween.tween_property(self, "zoom", Vector2(shake_goal,shake_goal), length)
		tween.set_parallel(true)
		tween.tween_property(self, "position", Vector2(960+random.randi_range(-10,10*intensity*4),540+random.randi_range(-10,10*intensity*4)), length)
		
		tween.set_parallel(false)
		tween.tween_property(self, "zoom", Vector2(1,1), length)
		tween.set_parallel(true)
		tween.tween_property(self, "position", Vector2(960,540), length)
		tween.set_parallel(false)
		intensity *= 0.3
		var recursive_delay = intensity*10*random.randfn(1.0,0.3)
		await get_tree().create_timer(recursive_delay).timeout
		
	
