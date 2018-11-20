extends Node2D

onready var left = get_node("left")
onready var right = get_node("right")
onready var right_collision = get_node("right/right_collision")
onready var left_collision = get_node("left/left_collision")
onready var left_sprite = get_node("left/left_sprite")
onready var right_sprite = get_node("right/right_sprite")
onready var level_counter = get_node("Level_counter")
onready var position_detect = get_node("Position")
onready var player_detector = get_node("left/player_detector")
var col_margin = 3
var inclose = false setget set_inclose,get_inclose
var next_level setget set_next_level,get_next_level
signal inclosure_end
signal move_camera
var camera_mover = Vector2(0,0)
var player_detector_height = Vector2(0,0)
var signal_emit = true
var player_collide = false
var screen_half 
var check_point_right
var check_point_left
var texture_height = 90 setget ,get_text_height
var level_size = ["res://assets/Level_Sizes/Level.png", "res://assets/Level_Sizes/375*135.png","res://assets/Level_Sizes/375*180.png"]

var left_vel= Vector2(1,0) setget set_left_vel
var right_vel = Vector2(-1,0) setget set_right_vel

#temp vars/funcs
var print_level = true

func display_level_counter():
	var pos = Vector2(self.get_position().x, self.get_text_height()/2)
	self.incrument_level_counter()
	var num = Global.get_level_num()
	var display_num = str(num)
	level_counter.set_text(display_num)
	level_counter.set_position(pos)

func incrument_level_counter():
	Global.set_level_num(1);

func display_position(value):
	var new_pos = Vector2(position_detect.get_position().x, self.get_text_height()/4)
	var pos = str(value)
	position_detect.set_text(pos)
	position_detect.set_position(new_pos)
#temp vars/funcs


func get_text_height():
	return texture_height

func set_next_level(value):
	next_level = value

func get_next_level():
	return next_level

func set_left_vel(value):
	left_vel.x = value

func set_right_vel(value):
	right_vel.x = -(value)

func get_inclose():
	return inclose

func set_inclose(value):
	inclose = value

func randome_level_heights():
	randomize()
	var size = round(rand_range(0,2))
	var texture = load(level_size[size])
	left_sprite.set_texture(texture)
	right_sprite.set_texture(texture)
	texture_height = texture.get_height()
	collision_maker()

func ChangePositionInParent(height):
	var new_pos_left = Vector2(0,height)
	var new_pos_right = Vector2(Global.get_screen_size().x, height)
	left.set_position(new_pos_left)
	right.set_position(new_pos_right)

func collision_maker():
	var left_h = (left_sprite.texture.get_height() - col_margin)/2
	var left_w = (left_sprite.texture.get_width() - col_margin)/2
	var right_h = (right_sprite.texture.get_height() - col_margin)/2
	var right_w = (right_sprite.texture.get_width() - col_margin)/2
	ChangePositionInParent(left_sprite.texture.get_height()/2)
	player_detector_height(left_h * 2)
	var colShapeRight = Vector2(right_w-1, right_h)
	var colShapeLeft = Vector2(left_w, left_h)
	right.add_to_group("levels")
	left.add_to_group("levels")
	screen_half = get_viewport_rect().size.x/2
	right_collision.get_shape().set_extents(colShapeRight)
	left_collision.get_shape().set_extents(colShapeLeft)
	check_point_right = right_collision.shape.get_extents().x
	check_point_left = left_collision.shape.get_extents().x/2
	camera_mover.y = left_h * 2

func player_detector_height(height):
	var botom_margin = 10
	var top_margin = 6
	var pos = player_detector.get_position()
	var new_pos = pos
	new_pos.y = (-height/2) + top_margin
	player_detector_height.y = height - botom_margin
	player_detector.set_cast_to(player_detector_height)
	player_detector.set_position(new_pos)

func _ready():
	self.collision_maker()
 
func inclose():
	var check_point = right.position.x - check_point_right
	
	if inclose == true && check_point > screen_half:
		#collision_maker()
		var right_pos = right.get_position()
		var left_pos = left.get_position()
		right_pos += right_vel
		left_pos += left_vel
		right.set_position(right_pos)
		left.set_position(left_pos)
		
	if check_point <= screen_half && signal_emit == true:
		emit_signal("inclosure_end")
		emit_signal("move_camera", camera_mover)
		
		signal_emit = false

func _process(delta):
	inclose()
	var checking_player_collision = player_detector.get_collider()
	if(checking_player_collision && player_collide == false):
		detect_player_collision(checking_player_collision)
		player_collide = true
	

func detect_player_collision(collision_info):
	if(collision_info.get_groups().has("player")):
		Global.set_player_dead(true)
	

func chain():
	inclose = true

func _on_levels_s_inclosure_end():
	if self.get_next_level() != null:
		self.get_next_level().chain()







