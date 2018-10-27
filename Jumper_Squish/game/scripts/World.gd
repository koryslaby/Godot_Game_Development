extends Node2D

onready var Levels = preload("res://scenes/Levels.tscn")
onready var player = get_node("player2")
onready var start = get_node("Start")
var closing_level = 0 setget set_cl,get_cl
var spawn = Vector2(0,1290)
var level_margin = 2
var max_levels = 10

func set_cl(value):
	closing_level = value

func get_cl():
	return closing_level

func _ready():
	start.add_to_group("base")
	var last_level
	var start = self.spawn_levels()
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
	return start

func _process(delta):
	pass
