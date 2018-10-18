extends RigidBody2D

var number
onready var lable = get_node("number")
onready var gp = get_node("Game_peice")
var pos = Vector2(20,0)
var fall = Vector2(0, 2)


var pieces = ['res://assets/Game_pieces/GP_red.png', 'res://assets/Game_pieces/GP_yellow.png',
			'res://assets/Game_pieces/GP_green.png', 'res://assets/Game_pieces/GP_orange.png',
			'res://assets/Game_pieces/GP_blue.png']

func _ready():
	randomize()
	var pick = round(rand_range(0, 4))
	print(pick)
	number = str(round(rand_range(1, 20)))
	print(number)
	gp.set_texture(load(pieces[pick]))
	lable.set_text(number)
	move_and_collide(fall)
	
	
	