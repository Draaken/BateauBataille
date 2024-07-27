extends ColorRect

var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	self.material.get_shader_parameter("noise_displace").noise.seed = rand.randi()
	self.material.get_shader_parameter("noise_foam").noise.seed = rand.randi()
	self.material.get_shader_parameter("noise_deform").noise.seed = rand.randi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
