extends Node2D
@onready var spawn_points = [$A,$B,$C,$D,$E,$F,$G,$H]
var random = RandomNumberGenerator.new()

var seagull1 = preload("res://Main/Level/Seagulls/Seagull1/seagull_1.tscn")

var is_active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	activate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func activate():
	await get_tree().create_timer(random.randi_range(5,10)).timeout
	if is_active:
		activate()
	
	is_active = true
	var rand1 = random.randi_range(0,spawn_points.size()-1)
	var rand2 = random.randi_range(0,spawn_points.size()-1)
	while (abs(rand1-rand2)<=2) || (abs(rand1-rand2)>=6):
		rand2 = random.randi_range(0,spawn_points.size()-1)
#test if the points index are the same or less than 1 appart

	var point1= spawn_points[rand1].global_position + Vector2(random.randi_range(-100,100),random.randi_range(-100,100))
	var point2 = spawn_points[rand2].global_position + Vector2(random.randi_range(-100,100),random.randi_range(-100,100))
	
	var instance = seagull1.instantiate()
	add_child(instance)
	instance.scale *= random.randfn(1.0,0.1)
	instance.global_position = point1
	instance.rotation = point1.angle_to_point(point2)
	
	var tween = get_tree().create_tween()
	tween.tween_property(instance, "global_position", point2, 1.7)
	await tween.finished
	instance.queue_free()
	is_active = false
	activate()
	
