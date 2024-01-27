class_name CanonballClass extends CharacterBody2D

var velocity_norm = 0
var initial_velocity = Vector2()
var velocity_sum = Vector2()
var timerExplode = Timer.new()
var timerSplash = Timer.new()
var timerLife = Timer.new()
var random = RandomNumberGenerator.new()
var shooter

var is_destructible = false
var damage_type = "Canonball"

var lifespan = 1
var damage

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
#	velocity -= velocity * 0.01
	initial_velocity -= initial_velocity * 0.1
	
	velocity_sum = velocity + initial_velocity
	
	var collision = move_and_collide(velocity_sum*delta)
	
	if collision && collision.get_collider() != shooter:
		explode(collision.get_collider())
		

func explode(target):
	timerExplode.connect("timeout", Callable(self, "end"))
	timerExplode.wait_time = 2
	timerExplode.one_shot = true
	add_child(timerExplode)
	timerExplode.start()
	
	$Sprite2D.hide()
	set_collision_mask_value(3, false)
	print("boom")
	
	
	
	if target.is_destructible:
		target.take_damage(damage, "Canonball")
		
	target.get_pushed(velocity/3.5)

	
	velocity = Vector2(0,0)
	
func splash():
	timerSplash.connect("timeout", Callable(self, "end"))
	timerSplash.wait_time = 2
	timerSplash.one_shot = true
	add_child(timerSplash)
	timerSplash.start()
	
	$Sprite2D.hide()
	set_collision_mask_value(3, false)
	
	velocity = Vector2(0,0)
	
	
func start():
	timerLife.connect("timeout", Callable(self, "splash"))
	timerLife.wait_time = lifespan
	timerLife.one_shot = true
	add_child(timerLife)
	timerLife.start()
	
	
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, false)
#	Cooldown in order than the canonball doesn't hit it's own boat when spawning
	var startTimer = Timer.new()
	startTimer.wait_time = 0.02
	startTimer.one_shot = true
	add_child(startTimer)
	startTimer.start()
	await startTimer.timeout
	
	
	set_collision_mask_value(3, true)
	print('loaded')

func end():
	self.queue_free()
