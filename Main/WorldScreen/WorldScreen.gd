extends Node2D

signal worldFinished
signal gameEnded


@onready var team1 = get_node("/root/Team1")
@onready var team2 = get_node("/root/Team2")

var team1_progress_bar
var team2_progress_bar


var is_game_ending = false
var score_goal = 3
var animation_time = 0.7

var chosen_map


@onready var timer = $Timer

func _process(_delta):
	if is_game_ending && (Input.is_action_pressed("P1Down") || Input.is_action_just_pressed("P2Down") || Input.is_action_just_pressed("P3Down") || Input.is_action_just_pressed("P4Down")):
		emit_signal("gameEnded")

func setup():
	team1_progress_bar = get_node("CenterContainer/MarginContainer/MarginContainer/HBoxContainer2/Team1Progress")
	team2_progress_bar = get_node("CenterContainer/MarginContainer/MarginContainer/HBoxContainer2/Team2Progress")
	
	team1_progress_bar.max_value = score_goal-1
	team2_progress_bar.max_value = score_goal-1
	
	var global_score = team1.wins - team2.wins
	var old_global_score = team1.old_wins - team2.old_wins
	print(team1.old_wins)
	print(team2.old_wins)
	
	if abs(global_score) >= score_goal:
		$VictoryScreen.show()
		is_game_ending = true
		
	else:
		set_progress_bar(old_global_score)
		
		if abs(global_score) == score_goal -1:
			chosen_map = load("res://Main/Level/Map/Fortress1/fortress1.tscn").instantiate()
		else:
			chosen_map = $"..".choose_map()
		
		if chosen_map is final_map_class:
			if global_score <= 0:
				chosen_map.set_up_defenses(1)
			elif global_score >= 0:
				chosen_map.set_up_defenses(2)
		
		
		
		timer.wait_time = 1.5
		timer.one_shot = true
		timer.start()
		await(timer.timeout)
		
		update_progress_bar(old_global_score, global_score)
	
	
#Used to initialise the bars when loading the scene
func set_progress_bar(value):
		
	if value <= 0:
		team1_progress_bar.value = abs(value)
		team2_progress_bar.value = 0
	elif value >= 0:
		team1_progress_bar.value = 0
		team2_progress_bar.value = abs(value)
	
#Animate the bars from one state to the other, by steps of one point
func update_progress_bar(old_value, new_value):
	var tween = create_tween()
	var dif = new_value-old_value
	var step
	if dif > 0:
		step = 1
	elif dif < 0:
		step = -1
	else:
		print_debug("The values are the same.")
		return(0)
		
	for i in range(0,abs(dif)):
		var temp_value = old_value+step
		if temp_value < 0:
			tween.tween_property(team1_progress_bar, "value", abs(temp_value), animation_time)
		elif temp_value > 0:
			tween.tween_property(team2_progress_bar, "value", abs(temp_value), animation_time)
		elif temp_value == 0:
			tween.tween_property(team1_progress_bar, "value", abs(temp_value), animation_time)
			tween.tween_property(team2_progress_bar, "value", abs(temp_value), animation_time)
			
		old_value = temp_value
		
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.start()
	await(timer.timeout)
	emit_signal("worldFinished", chosen_map)
		
