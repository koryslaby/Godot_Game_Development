extends Node2D

onready var left = get_node("left")
onready var right = get_node("right")
onready var right_collision = get_node("right/right_collision")
onready var left_collision = get_node("left/left_collision")
onready var left_sprite = get_node("left/left_sprite")
onready var right_sprite = get_node("right/right_sprite")
var col_margin = 3
var inclose = false setget set_inclose,get_inclose
var next_level setget set_next_level,get_next_level
signal inclosure_end
var x = 1
var screen_half 
var check_point_right
var check_point_left

var left_vel= Vector2(1,0) setget set_left_vel
var right_vel = Vector2(-1,0) setget set_right_vel

func set_next_level(value):
	next_level = value

func get_next_level():
	return next_level

func set_left_vel(value, object):
	object = value

func set_right_vel(value, object):
	object = value

func get_inclose():
	return inclose

func set_inclose(value):
	inclose = value

func _ready():
	var left_h = (left_sprite.get_sprite_frames().get_frame("default", 0).get_height() - col_margin)/2
	var left_w = (left_sprite.get_sprite_frames().get_frame("default", 0).get_width() - col_margin)/2
	var right_h = (right_sprite.get_sprite_frames().get_frame("default", 0).get_height() - col_margin)/2
	var right_w = (right_sprite.get_sprite_frames().get_frame("default", 0).get_width() - col_margin)/2
	var colShapeRight = Vector2(right_w-1, right_h)
	var colShapeLeft = Vector2(left_w, left_h)
	right.add_to_group("levels")
	left.add_to_group("levels")
	screen_half = get_viewport_rect().size.x/2
	inclose = true
	right_collision.get_shape().set_extents(colShapeRight)
	left_collision.get_shape().set_extents(colShapeLeft)
	check_point_right = right_collision.shape.get_extents().x
	check_point_left = left_collision.shape.get_extents().x/2
 
	print("right collision is: ", right_collision.get_shape().get_extents())

func _process(delta):
	
	var check_point = right.position.x - check_point_right
	if inclose == true && check_point > screen_half:
		var right_pos = right.get_position()
		var left_pos = left.get_position()
		right_pos += right_vel
		left_pos += left_vel
		right.set_position(right_pos)
		left.set_position(left_pos)

func chain():
	print("chain")
	self.set_inclose(true)
	

func _on_Levels_inclosure_end():
	if self.get_next_level() != null:
		self.get_next_level().chain()


