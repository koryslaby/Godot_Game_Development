extends Node2D

var gp_pos = Vector2()
var floor_pos = Vector2(375,1334)
var next = 0
var first_piece = true 
onready var gp = preload("res://scenes/Game_Piece.tscn")
onready var Piece_drop = get_node("piece_drop")
onready var game_floor = get_node("Floor/floor")
onready var buttons = get_node("UI/Main_screen_button")
onready var ui = get_node("UI")

var spawn_points = [60, 150, 240, 330, 420, 510, 600, 690]
onready var gp_list = []

func _ready():
	Piece_drop.start()
	randomize()
	game_floor.set_position(floor_pos)
	buttons.connect("block_switch_click", self, "on_buttons_block_switch_click")
	buttons.connect("right_click", self, "on_buttons_right_click")
	buttons.connect("left_click", self, "on_buttons_left_click")

func Gp_spawn():
	if Piece_drop.is_stopped():
		gp_pos.x = spawn_points[rand_range(0,8)]
		gp_pos.y = 0
		var new_gp = gp.instance()
		new_gp.connect("is_colliding", self, "on_new_gp_is_colliding")
		add_child_below_node(Piece_drop, new_gp)
		gp_list.append(new_gp)
		new_gp.set_position(gp_pos)
		if gp_list.size() < 2:
			new_gp.set_is_selected(true)
		Piece_drop.start()

func gp_select(peice):
	peice.set_is_selected(true)

func _process(delta):
	Gp_spawn()
	if(!gp_list.empty() && first_piece == true):
		var path = gp_list[0]
		gp_select(path)
		first_piece = false
	
	

func on_new_gp_is_colliding():
	var path = gp_list[0]
	var next_path
	if gp_list.size() > 1:
		next_path = gp_list[1]
		if(path.get_is_selected() == true):
			path.set_is_selected(false)
			next_path.set_is_selected(true)
	if gp_list.size() == 1:
		path.set_is_selected(false)
	
	var size = (gp_list.size() - 1)
	gp_list.remove(0)
	gp_list.resize(size)
	if(next > 0):
		next-=1

func on_buttons_block_switch_click():
	var old_path = gp_list[next]
	if((next+1) <= gp_list.size()-1):
		next += 1
		var path = gp_list[next]
		path.set_is_selected(true)
		old_path.set_is_selected(false) 

func on_buttons_right_click():
	print("on buton right click")
	if(gp_list.size() > 0):
		var path = gp_list[next]
		path.set_dir_rot("right")
		path.rotate("right")

func on_buttons_left_click():
	print("onbutton right click")
	if(gp_list.size() > 0):
		var path = gp_list[next]
		path.set_dir_rot("left")
		path.rotate("left")