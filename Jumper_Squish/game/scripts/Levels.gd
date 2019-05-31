extends Node2D

onready var left = get_node("Left")
onready var right = get_node("Right")
onready var right_collision = get_node("Right/right_collision")
onready var left_collision = get_node("Left/left_collision")
onready var left_sprite = get_node("Left/left_sprite")
onready var right_sprite = get_node("Right/right_sprite")
var col_margin = 3
var inclose = false setget set_inclose,get_inclose
var next_level setget set_next_level,get_next_level
signal inclosure_end

var left_vel= Vector2(1,0) setget set_left_vel
var right_vel = Vector2(-1,0) setget set_right_vel

func set_next_level(value):
	next_level = value

func get_next_level():
	return next_level

func set_left_vel(value):
	left_vel = value

func set_right_vel(value):
	right_vel = value

func get_inclose():
	return inclose

func set_inclose(value):
	inclose = value

func _ready():
	var left_h = (left_sprite.get_texture().get_height() - col_margin)/2
	var left_w = (left_sprite.get_texture().get_width() - col_margin)/2
	var right_h = (right_sprite.get_texture().get_height() - col_margin)/2
	var right_w = (right_sprite.get_texture().get_width() - col_margin)/2
	var colShapeRight = Vector2(right_w, right_h)
	var colShapeLeft = Vector2(left_w, left_h)
	right.add_to_group("levels")
	left.add_to_group("levels")
	
	right_collision.get_shape().set_extents(colShapeRight)
	left_collision.get_shape().set_extents(colShapeLeft)

#warning-ignore:unused_argument
func _physics_process(delta):
	if self.get_inclose() == true:
		var collision_info_left = left.move_and_collide(left_vel)
		var collision_info_right = right.move_and_collide(right_vel)
		if collision_info_left && collision_info_right && collision_info_right.collider.get_groups().has("levels"):
			print("colliding with level")
			set_inclose(false)
			self.add_to_group("base")
			emit_signal("inclosure_end")

func chain():
	print("chain")
	self.set_inclose(true)
	

func _on_Levels_inclosure_end():
	if self.get_next_level() != null:
		self.get_next_level().chain()
















