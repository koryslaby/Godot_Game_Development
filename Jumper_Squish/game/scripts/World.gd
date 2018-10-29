extends Node2D

onready var Levels = preload("res://scenes/levels_s.tscn")
onready var player = get_node("player2")
onready var start = get_node("Start")
onready var camera = get_node("level_movement")
onready var camera_tween = get_node("smoth_camera_movement")
var closing_level = 0 
var spawn = Vector2(0,1290)
var camera_start_position = Vector2()
var level_margin = 2
var max_levels = 100


func _ready():
	start.add_to_group("base")
	var last_level
	
	var start = self.spawn_levels()
	camera_start_position = camera.get_position()
	start.chain()
	
	

func spawn_levels():
	var last_level
	var start
	for i in range(0,max_levels):
		var new_level = Levels.instance()
		add_child_below_node(player, new_level)
		new_level.set_position(spawn)
		spawn.y -= 90 - level_margin
		if i > 0:
			last_level.set_next_level(new_level)
		if i == 0:
			start = new_level
		last_level = new_level
		new_level.connect("move_camera", self, "_on_new_level_move_camera")
		
	return start

func _on_new_level_move_camera(camera_mover):
	print("on new level move camera")
	var camera_movement = camera_start_position - camera_mover
	camera_tween.interpolate_property(camera, "position", camera_start_position, camera_movement, 1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	camera_tween.start()
	camera_start_position = camera_movement

func _process(delta):
	pass
