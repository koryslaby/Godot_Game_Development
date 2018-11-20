extends RigidBody2D

onready var collision = get_node("player_collision")
onready var p_anim = get_node("player_anim")
onready var gd = get_node("ground_detector")
var ogravity = Vector2(0,4)
var jump = Vector2(0,-6)
var offset = Vector2(0,0)
var impulse = Vector2(0,-400)
var spawn_pos = Vector2(375,1044)
signal jump_anim_done

func _ready():
	self.add_to_group("player")
	collision.shape.extents.x = int(p_anim.get_sprite_frames().get_frame("default", 0).get_height())/2
	collision.shape.extents.y = int(p_anim.get_sprite_frames().get_frame("default", 0).get_width())/2
	set_process_input(true)

func _integrate_forces(state):
	if(p_anim.get_animation() == "Jump_up" && p_anim.get_frame() == 14):
		emit_signal("jump_anim_done")

func _input(event):
	if event.is_action_pressed("Jump"):
		if gd.is_colliding():
			p_anim.set_animation("Jump_up")
			apply_impulse(offset, impulse)

func _on_player2_jump_anim_done():
	p_anim.set_animation("default")
