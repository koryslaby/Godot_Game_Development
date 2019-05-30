extends Node2D

onready var Levels = preload("res://scenes/levels_s.tscn")
onready var player_died_popup = preload("res://scenes/player_died.tscn")
onready var start = get_node("Start")
onready var camera = get_node("level_movement")
onready var camera_tween = get_node("smoth_camera_movement")
onready var top = get_node("top")
var spawn = Vector2(0,1333)
var camera_start_position = Vector2()
var max_levels = 100
var camera_move = Vector2(0,0)

func _ready():
	print(Global.connect("player_dead", self, "_on_Global_player_dead"))
	start.add_to_group("base")
	randomize()
	
	var start = self.spawn_levels()
	camera_start_position = camera.get_position()
	start.chain()

func random_speeds(level):
	var speeds = [1,1.5,2,2.5,3]
	var vel = speeds[round(rand_range(0,4))]
	level.set_left_vel(vel)
	level.set_right_vel(vel)

func spawn_levels():
	var last_level
	var start
	for i in range(0,max_levels):
		var new_level = Levels.instance()
		add_child_below_node(top , new_level)
		if Global.diff_speeds == true:
			random_speeds(new_level)
		if Global.collors == true:
			pass
		if Global.diff_heights == true:
			new_level.randome_level_heights()
		spawn.y -= new_level.get_text_height()
		new_level.display_level_counter()
		new_level.set_position(spawn)
		new_level.display_position(new_level.get_position().y)
		if i > 0:
			last_level.set_next_level(new_level)
		if i == 0:
			start = new_level
		last_level = new_level
		new_level.connect("move_camera", self, "_on_new_level_move_camera")
		
		
	return start

func _on_new_level_move_camera(camera_mover):
	var camera_movement = camera_start_position - camera_mover
	camera_tween.interpolate_property(camera, "position", camera_start_position, camera_movement, 1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	camera_tween.start()
	camera_start_position = camera_movement
	camera_move = camera_mover

func _on_Global_player_dead():
	var new_popup = player_died_popup.instance()
	var pos = Vector2(Global.screen_size.x/2, camera_start_position.y + camera_move.y)
	add_child(new_popup)
	new_popup.set_position(pos)
	new_popup.show()
