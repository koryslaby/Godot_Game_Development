extends Area2D

var shape = Vector2()
onready var game_peice = get_node("Player")
onready var colider = get_node("colider")
var pos = Vector2(50,50)

var gp_select = ["res://assets/Game_pieces/GP_blue.png", "res://assets/Game_pieces/GP_green.png",
"res://assets/Game_pieces/GP_orange.png", "res://assets/Game_pieces/GP_red.png",
"res://assets/Game_pieces/GP_yellow.png"]

func _ready():
	var texture = load(gp_select[rand_range(0,5)])
	shape.x = texture.get_width()
	shape.y = texture.get_height()
	game_peice.set_texture(texture)
	colider.get_shape().set_extents(shape)
	self.set_position(pos)
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
