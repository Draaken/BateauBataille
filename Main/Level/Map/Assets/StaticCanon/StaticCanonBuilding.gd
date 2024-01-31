extends HitableObject

var r_velocity = 0
var r_acc = 0.6 #cosnt
var target_list = []
var target
var is_locked = false
var canon
var reload_time = 6
var random = RandomNumberGenerator.new()

func _ready():
	super()
	
	team = 0
	is_destructible = true
	hit_points = 3
	
	canon = $Canon
	canon.reload_time = reload_time
	
	random.randomize()

func _physics_process(delta):
	$LockedIndicator.hide()
	if is_locked:
		seek_target(delta)
		
	

func seek_target(delta):
	
	$RayCast.target_position = to_local(target.global_position)
	
	var angle_to_target = self.get_angle_to(target.global_position)
	#var angle_to_target = atan2(target.global_position.y - global_position.y, target.global_position.x - global_position.x)
	angle_to_target += PI/2
	
	var turn = abs(angle_to_target)/angle_to_target
	
	r_velocity = turn * r_acc * delta
	rotation += r_velocity
	
	if $RayCast.get_collider() == target:
		#$LockedIndicator.show()
		if angle_to_target < PI/32 && angle_to_target > -PI/32:
			if  canon.is_reloaded && random.randf_range(0,1) > 0.99:
			#randomness factor so that the gun don't instantly shoot when reloaded
				canon.shoot(self)
		
	
#func reload(delta):
	#
	#reload_progress += 100 * delta
	#if reload_progress >= reload_time:
		#reload_progress = 0
		#if canon.is_reloaded == false:
				#canon.reload()
	#

func take_damage(damage, damage_type):
	super(damage, damage_type)
	if hit_points <= 0:
		self.queue_free()

func _on_target_entered(body):
	if body.team != self.team && body.team != 0:
		target_list.append(body)
		if target_list.size() == 1:
			target = target_list[0]
			
		is_locked = true


func _on_target_exited(body):
	if body.team != self.team && body.team != 0:
		for i in range(target_list.size() - 1, -1, -1):
				if target_list[i] == body:
					target_list.remove_at(i)
					
		if target_list.size() == 0:
			target = null
			is_locked = false
		else:
			target = target_list[target_list.size()-1]
			is_locked = true
	
