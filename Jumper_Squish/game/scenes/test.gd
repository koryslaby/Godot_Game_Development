extends Node2D

onready var test_level = get_node("levels_s")

func _ready():
	test_level.chain()

