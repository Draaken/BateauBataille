extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#Ne marche plus, à réparer !!
func _process(_delta):
	set_text("FPS " + str(Engine.get_frames_per_second()))

