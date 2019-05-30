extends Node

var diff_speeds = false setget set_diff_speeds
var collors = false setget set_collors
var diff_heights = false setget set_diff_heights
var level = 0 setget set_level_num,get_level_num
var screen_size = Vector2(750,1333) setget set_screen_size,get_screen_size
var player_dead = false setget set_player_dead, get_player_dead
var send_player_dead_signal = false
signal player_dead

#warning-ignore:unused_argument
func _process(delta):
	if(send_player_dead_signal == false && player_dead == true):
		emit_signal("player_dead")
		send_player_dead_signal = true

func set_player_dead(value):
	player_dead = value

func get_player_dead():
	return player_dead

func set_diff_speeds(value):
	diff_speeds = value

func set_collors(value):
	collors = value

func set_diff_heights(value):
	diff_heights = value
	
func set_level_num(value):
	level += value

func get_level_num():
	return level

func set_screen_size(value):
	screen_size = value

func get_screen_size():
	return screen_size