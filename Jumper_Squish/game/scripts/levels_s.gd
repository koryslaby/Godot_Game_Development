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
signal move_camera
var camera_mover = Vector2(0,0)
var signal_emit = true
var screen_half 
var check_point_right
var check_point_left
var texture_height = 90 setget ,get_text_height
var level_size = ["res://assets/Level_Sizes/Level.png", "res://assets/Level_Sizes/375*135.png","res://assets/Level_Sizes/375*180.png"]

var left_vel= Vector2(1,0) setget set_left_vel
var right_vel = Vector2(-1,0) setget set_right_vel


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

func collision_maker():
	var left_h = (left_sprite.texture.get_height() - col_margin)/2
	var left_w = (left_sprite.texture.get_width() - col_margin)/2
	var right_h = (right_sprite.texture.get_height() - col_margin)/2
	var right_w = (right_sprite.texture.get_width() - col_margin)/2
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

func _ready():
	pass
 
func inclose():
	var check_point = right.position.x - check_point_right
	if inclose == true && check_point > screen_half:
		collision_maker()
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
		

func chain():
	inclose = true

func _on_levels_s_inclosure_end():
	if self.get_next_level() != null:
		self.get_next_level().chain()







