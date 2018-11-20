extends RigidBody2D

onready var collision = get_node("player_collision")
onready var p_anim = get_node("player_anim")
onready var gd = get_node("ground_detector")
onready var explosion = get_node("explosions")
var ogravity = Vector2(0,4)
var jump = Vector2(0,-6)
var offset = Vector2(0,0)
var impulse = Vector2(0,-400)
var spawn_pos = Vector2(375,1044)

func _ready():
	Global.connect("player_dead", self, "_on_Global_player_dead")
	p_anim.connect("animation_finished", self, "_on_p_anim_animation_finished")
	self.add_to_group("player")
	self.set_mode(RigidBody2D.MODE_CHARACTER)
	collision.shape.extents.x = int(p_anim.get_sprite_frames().get_frame("default", 0).get_height())/2
	collision.shape.extents.y = int(p_anim.get_sprite_frames().get_frame("default", 0).get_width())/2
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("Jump"):
		if gd.is_colliding():
			if(Global.get_player_dead() == false):
				p_anim.set_animation("Jump_up")
				apply_impulse(offset, impulse)

func _on_Global_player_dead():
	self.set_mode(RigidBody2D.MODE_STATIC)
	collision.set_disabled(true)
	p_anim.set_animation("player_dead")


func _on_p_anim_animation_finished():
	if(p_anim.get_animation() == "player_dead"):
		explosion.set_emitting(true)
	
	if(p_anim.get_animation() == "Jump_up"):
		p_anim.set_animation("default")
