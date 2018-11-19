extends Node

var diff_speeds = false setget set_diff_speeds
var collors = false setget set_collors
var diff_heights = false setget set_diff_heights
var level = 0 setget set_level_num,get_level_num
var screen_size = Vector2(750,1333) setget set_screen_size,get_screen_size

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