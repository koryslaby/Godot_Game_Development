extends Control

#var scene = load("res://scenes/World.tscn")
onready var screen_size = self.get_viewport_rect().size
onready var Levels = preload("res://scenes/levels_s.tscn")
var spawn = Vector2(0,1333)

func spawn_show_levels():
	var last_level
	var start
	for i in range(0,15):
		var new_level = Levels.instance()
		add_child_below_node($Background , new_level)
		new_level.randome_level_heights()
		spawn.y -= new_level.get_text_height()
		new_level.set_position(spawn)
		if i > 0:
			last_level.set_next_level(new_level)
		if i == 0:
			start = new_level
		last_level = new_level
	return start

func _ready():
	Global.set_diff_speeds(false)
	Global.set_diff_heights(false)
	Global.set_collors(false)
	print("screen size is: ", screen_size)
	Global.set_screen_size(screen_size)
	
	var start = self.spawn_show_levels()
	start.chain()


func _on_Button1_button_up():
	Global.set_diff_speeds(true)
	print(get_tree().change_scene("res://scenes/World.tscn"))


func _on_Button2_button_up():
	Global.set_diff_heights(true)
	print(get_tree().change_scene("res://scenes/World.tscn"))


func _on_Button3_button_up():
	Global.set_collors(true)
	print( get_tree().change_scene("res://scenes/World.tscn"))
