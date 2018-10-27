extends KinematicBody2D

onready var texture = get_node("player_texture")
onready var collision = get_node("Player_collision")
onready var ground_detection = get_node("ground_detection")
var vel = Vector2(0,120)
var gra = 2
var jump_force = Vector2(0, -1)
var is_colliding setget set_colliding, get_colliding

func _ready():
	set_process_input(true)
	collision.shape.extents.x = int(texture.get_sprite_frames().get_frame("test_default", 0).get_height())/2
	collision.shape.extents.y = int(texture.get_sprite_frames().get_frame("test_default", 0).get_width())/2
	add_to_group("player")

func _physics_process(delta):
	var collision_info = move_and_collide(vel * delta * gra)
	
	if(collision_info):
		self.set_colliding(true)
	

func _input(event):
	if event.is_action_pressed("Jump"):
		if ground_detection.is_colliding():
			var jump = move_and_collide(vel * jump_force)

func set_colliding(colliding):
	is_colliding = colliding

func get_colliding():
	return is_colliding