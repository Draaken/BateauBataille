extends HitableObject

@export var is_neutral = true
var is_active = true
var r_velocity = 0
var r_acc = 0.6 #cosnt
var target_list = []
var target
var is_locked = false
var can_move = true
var canon
var reload_time = 3
var aim_time = 0.5
var random = RandomNumberGenerator.new()
var damage_type = "Boat"
var retarget_clock = 0

func desactivate():
	$DetectionRange.monitoring = false
	self.hide()
	is_active = false
	
func _ready():
	super()
	
	is_destructible = true
	hit_points = 2
	can_move = true
	
	canon = $Canon
	canon.reload_time = reload_time
	
	random.randomize()

func _physics_process(delta):
	$LockedIndicator.hide()
	if is_active && is_locked && can_move:
		seek_target(delta)
	retarget_clock += delta
	if retarget_clock > 1:
		retarget_clock = 0
		if target_list.size() > 0:
			target = get_closest_target()
	

func seek_target(delta):
	
	$RayCast.target_position = to_local(target.global_position)
	
	var angle_to_target = self.get_angle_to(target.global_position)
	#var angle_to_target = atan2(target.global_position.y - global_position.y, target.global_position.x - global_position.x)
	angle_to_target += PI/2
	
	var turn = abs(angle_to_target)/angle_to_target
	
	r_velocity = turn * r_acc * delta
	rotation += r_velocity
	
	if $RayCast.get_collider() == target && not target.is_invisible:
		#$LockedIndicator.show()
		if angle_to_target < PI/32 && angle_to_target > -PI/32:
			if  canon.is_reloaded && random.randf_range(0,1) > 0.9:
				#randomness factor so that the gun don't instantly shoot when reloaded
				
				#stop the canon from rotating briefly before shooting, to mess with the aim
				can_move = false
				
				$AimTimer.wait_time = aim_time
				$AimTimer.one_shot = true
				$AimTimer.start()
				
				await $AimTimer.timeout
				
				can_move = true
			
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
			target = get_closest_target()
			is_locked = true
	
func get_closest_target():
	var closest_target = null
	var closest_distance = 10000000
	for body in target_list:
		if not body.is_invisible || target_list.size() == 1:
			if body.global_position.distance_to(self.global_position) < closest_distance:
				closest_distance = body.global_position.distance_to(self.global_position)
				closest_target = body
	if closest_target == null:
		pass
	return closest_target
