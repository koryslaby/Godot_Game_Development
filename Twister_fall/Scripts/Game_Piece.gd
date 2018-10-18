extends KinematicBody2D

onready var game_piece = get_node("player")
onready var collide = get_node("collider_shape")
onready var gp_number = get_node("number")
onready var selected = get_node("Selected")
var brick = "res://assets/Game_pieces/GP_brick.png"
signal is_colliding
signal score
var dir_rot setget set_dir_rot,get_dir_rot
var collision = false
var picker setget ,get_picker
var is_selected = false setget ,get_is_selected
var collision_info
var object_down setget object_down, get_down
var object_up setget object_up, get_up
var shape = Vector2()
var vol = Vector2(0,4)
var collor_name setget set_collor_name, collor_name_get
export var highest_number = 15 setget high_num_set, high_num_get
var num
var collor

var directions = ["up", "down", "left", "right"]

var gp_select = ["res://assets/Game_pieces/GP_blue.png", "res://assets/Game_pieces/GP_green.png",
"res://assets/Game_pieces/GP_orange.png", "res://assets/Game_pieces/GP_red.png",
"res://assets/Game_pieces/GP_yellow.png"]

var collors = ["blue", "green", "orange", "red", "yellow"]

func _ready():
	add_to_group("Block")
	randomize()
	picker = round(rand_range(0,4))
	collor = collors[picker]
	self.set_collor_name(collor)
	var texture = load(gp_select[picker])
	game_piece.set_texture(texture)
	shape.x = (texture.get_width()/2) - 1
	shape.y = (texture.get_height()/2) - 1
	collide.get_shape().set_extents(shape)
	num = round(rand_range(0,highest_number-1))
	gp_number.set_text(str(num))
	selected.connect("animation_finished",self,"on_selected_animation_finished")


#getters and setters
#####################################
func collor_name_get():
	return collor_name
func set_collor_name(collor):
	collor_name = collor
func change_animation(animation):
	$Selected.set_animation(animation)
func get_picker():
	return picker
func high_num_get():
	return highest_number
func high_num_set(value):
	highest_number = value
func object_up(object):
	object_up = object
func object_down(object):
	object_down = object
func get_up():
	return object_up
func get_down():
	return object_down
func change_collor(var c_change):
	for i in collors.size():
		if collors[i] == c_change:
			var new_collor = load(gp_select[i])
			game_piece.set_texture(new_collor)
			self.set_collor_name(c_change)
			collor = c_change
func change_number(var n_change):
	if n_change <= highest_number && n_change >= 0:
		gp_number.set_text(str(n_change))
		gp_number.update()
		self.num = n_change
func get_number():
	return int(self.gp_number.get_text())
func get_collor():
	return collor
func get_is_selected():
	return is_selected
func set_is_selected(setter):
	self.is_selected = setter
func set_dir_rot(setter):
	dir_rot = setter
func get_dir_rot():
	return dir_rot
#####################################

func _physics_process(delta):
	collision_info = move_and_collide(vol)
	
	if collision_info && collision == false:
		print("----------------------------")
		collision = true
		emit_signal("is_colliding")
		
		if(collision_info.collider.get_groups().has("Block")):
			self.object_down(collision_info.collider)
			collision_info.collider.object_up(self)
			block_colide(collision_info.collider)
		else:
			object_down(collision_info.get_collider())
	
	if(self.get_is_selected() == true):
		selected(true)
	else:
		selected(false)

#changes the collor if colliding blocks if number is higher
func numbers_check(object, run):
	if(run == true):
		if(object.get_number() < self.get_number()):
			print("top collor is: ", self.collor_name_get())
			object.change_collor(self.get_collor())
			print("new bottom collor is: ", object.get_collor())
		if(object.get_number() > self.get_number()):
			print("botom collor is: ", object.get_collor())
			self.change_collor(object.collor_name_get())
			print("new top collor is: ", object.get_collor())
	

#drips down the numbers
func number_drop(object, distrubuted_score, num):
	var ten_block = object
	numbers_check(object, num)
	num = false
	
	if !ten_block.get_down().get_groups().has("base") && ten_block.get_down().get_number() < self.high_num_get():
		number_drop(ten_block.get_down(), distrubuted_score, num)
	
	if ten_block.get_down().get_groups().has("base") || ten_block.get_down().get_number() == high_num_get():
		var num_to_change = ten_block.get_number()
		for i in range(0, distrubuted_score):
			if num_to_change < self.high_num_get():
				num_to_change += 1
				distrubuted_score -= 1
			if num_to_change == self.high_num_get():
				object.add_to_group("base")
				var new_brick = load(brick)
				object.gp_number.queue_free()
				object.game_piece.set_texture(new_brick)
		self.change_number(distrubuted_score)
		ten_block.change_number(num_to_change)

#executes when blocks collide & checks to see if the collors and numbers match
func block_colide(block):
	if block.get_collor() == self.get_collor() && block.get_number() == self.get_number():
		block_destroy()
		block.block_destroy()
	number_drop(block, self.get_number(), true)	
	 
	if block.get_collor() == self.get_collor() && block.get_number() == self.get_number():
		block.get_down().object_up(self.get_up())
		block_destroy()
		block.block_destroy()

#destroys blocks, called when two are the same collor and number
func block_destroy():
	queue_free()

#if the player is selected then it plays the animated sprite
func selected(selected):
	if(selected == true):
		$Selected._set_playing(true)
	else:
		$Selected._set_playing(false)
		$Selected.set_frame(0)

func rotate(direction):
	var left_rot = ["blue_left", "green_left", "orange_left", "red_left", "yellow_left"]
	var right_rot = ["blue_right", "green_right", "orange_right", "red_right", "yellow_right"]
	$player.set_texture(null)
	
	if(direction == "left"):
		$Selected.set_animation(left_rot[self.get_picker()])
	elif(direction == "right"):
		$Selected.set_animation(left_rot[self.get_picker()])
	$Selected._set_playing(true)

func area_collor_check():
	pass
	

	
func on_selected_animation_finished():
	if(self.get_is_selected() == true && $Selected.get_animation() != "default"):
		change_animation("default")
		self.change_collor(collors[self.get_picker()])
		var new_number = self.get_number()
		if(self.get_dir_rot() == "left"):
			if(new_number <= 0):
				new_number = self.high_num_get() - 1
			else:
				new_number-=1
		elif(self.get_dir_rot() == "right"):	
			if(new_number >= self.high_num_get() - 1):
				new_number = 0
			else:
				new_number+=1
		self.change_number(new_number)