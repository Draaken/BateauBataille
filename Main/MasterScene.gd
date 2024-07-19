extends CanvasLayer



var level = preload("res://Main/Level/Level.tscn")
var shop = preload("res://Main/Shop/Scenes/shop.tscn")
var selection = preload("res://Main/Menus/SelectionScreen/selection_screen.tscn")
var world = preload("res://Main/WorldScreen/WorldScreen.tscn")

#Maps
var arc1 = preload("res://Main/Level/Map/Archipello 1/Archipello1.tscn")
var rbay = preload("res://Main/Level/Map/RingBay/ringbay.tscn")
var lisland = preload("res://Main/Level/Map/LoneIsland/loneisland.tscn")
var reef1 = preload("res://Main/Level/Map/Reefs 1/reefs1.tscn")

var random = RandomNumberGenerator.new()

var map_list = [arc1, rbay, reef1]
#var map_list = [rbay]

var players_list = []

func _ready():
	load_selection()




#func change_menu(old_scene, new_scene_res):
#	var instance = new_scene_res.instantiate()
#	add_child(instance)
#	old_scene.queue_free()

#________________________________________________________________________

#Load the team selection scene to the tree
func load_selection():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var instance = selection.instantiate()
	add_child(instance)
	$SelectionScreen.connect("startGame", Callable(self, "selectionFinished"))
	$SelectionScreen.connect("backToMenu", Callable(self, "selectionCancelled"))
	
	get_node("/root/Player1").reset()
	get_node("/root/Player2").reset()
	get_node("/root/Player3").reset()
	get_node("/root/Player4").reset()
	
	
	get_node("/root/Team1").reset()
	get_node("/root/Team2").reset()
	get_node("/root/Team3").reset()
	get_node("/root/Team4").reset()
	
	
func selectionFinished():
	load_level()
	#load_shop()
	remove_child($SelectionScreen)
	
func selectionCancelled():
	pass
	
#________________________________________________________________________

#Load the main level scene to the tree
func load_level():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Loading.show()
	
	var instance = level.instantiate()
	var map = choose_map()
	instance.add_child(map)
	instance.map = map
	add_child(instance)
	
	
	$"Level".connect("roundFinished", Callable(self, "roundFinished"))
	$"Level".connect("roundCancelled", Callable(self, "roundCancelled"))
	
	$Loading.hide()
	
	
func roundFinished(_team):
	load_world()
	$"WorldScreen".show()
	$WorldScreen.setup()
	remove_child($Level)
	
func roundCancelled():
	load_selection()
	remove_child($Level)
	
func choose_map():
	random.randomize()
	var map = map_list[random.randi_range(0, map_list.size()-1)].instantiate() 
	#choose a map randomly in the list
	return map
	
#________________________________________________________________________
	
func load_shop():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var instance = shop.instantiate()
	add_child(instance)
	$"Shop".connect("shopFinished", Callable(self, "shopFinished"))
	
func shopFinished():
	load_level()
	remove_child($Shop)
	
#________________________________________________________________________

func load_world():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var instance = world.instantiate()
	add_child(instance)
	$"WorldScreen".hide()
	$"WorldScreen".connect("worldFinished", Callable(self, "worldFinished"))
	$"WorldScreen".connect("gameEnded", Callable(self, "gameEnded"))
	
	
func worldFinished():
	load_shop()
	remove_child($WorldScreen)
	
func gameEnded():
	load_selection()
	remove_child($WorldScreen)
	get_node("/root/Player1").reset()
	get_node("/root/Player2").reset()
	get_node("/root/Player3").reset()
	get_node("/root/Player4").reset()
	
	
	get_node("/root/Team1").reset()
	get_node("/root/Team2").reset()
	get_node("/root/Team3").reset()
	get_node("/root/Team4").reset()
	
	
	
