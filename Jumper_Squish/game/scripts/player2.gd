extends RigidBody2D

onready var collision = get_node("player_collision")
onready var p_anim = get_node("player_anim")
onready var gd = get_node("ground_detector")
onready var explosion = get_node("explosions")
var offset = Vector2(0,0)
var impulse = Vector2(0,-400)
var jump = false
signal animation_done

func _ready():
	print(Global.connect("player_dead", self, "_on_Global_player_dead"))
	p_anim.connect("animation_finished", self, "_on_p_anim_animation_finished")
	self.add_to_group("player")
	self.set_mode(RigidBody2D.MODE_CHARACTER)
	explosion.set_emitting(false)
	collision.set_disabled(false)
#warning-ignore:integer_division
	collision.shape.extents.x = int(p_anim.get_sprite_frames().get_frame("default", 0).get_height())/2
#warning-ignore:integer_division
	collision.shape.extents.y = int(p_anim.get_sprite_frames().get_frame("default", 0).get_width())/2
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("Jump") or jump == true:
		if gd.is_colliding():
			if(Global.get_player_dead() == false):
				p_anim.set_animation("Jump_up")
				apply_impulse(offset, impulse)
	jump = false

func _on_Global_player_dead():
	print("player has died")
	self.set_mode(RigidBody2D.MODE_STATIC)
	collision.set_disabled(true)
	p_anim.set_animation("player_dead")


func _on_p_anim_animation_finished():
	if(p_anim.get_animation() == "player_dead"):
		explosion.set_emitting(true)
	
	if(p_anim.get_animation() == "Jump_up"):
		p_anim.set_animation("default")

func _on_player_anim_animation_finished():
	if(p_anim.animation == "player_dead"):
		emit_signal("animation_done")

func _on_TouchButton_pressed():
	jump = true
