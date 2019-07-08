extends RigidBody2D

onready var collision = get_node("player_collision")
onready var p_anim = get_node("player_anim")
onready var gd = get_node("ground_detector")
onready var l_detect = get_node("left_detect")
onready var r_detect = get_node("right_detect")
onready var explosion = get_node("explosions")
var offset = Vector2(0,0)
var impulse = Vector2(0,-400)
var jump = false
var slide_motion = 4
signal animation_done
var side_move = false

func _ready():
	print(Global.connect("player_dead", self, "_on_Global_player_dead"))
	p_anim.connect("animation_finished", self, "_on_p_anim_animation_finished")
	self.add_to_group("player")
	self.set_mode(RigidBody2D.MODE_CHARACTER)
	explosion.set_emitting(false)
	collision.set_disabled(false)
#warning-ignore:integer_division
	#collision.shape.extents.x = int(p_anim.get_sprite_frames().get_frame("default", 0).get_height())/2
#warning-ignore:integer_division
	#collision.shape.extents.y = int(p_anim.get_sprite_frames().get_frame("default", 0).get_width())/2
	collision.shape.set_radius(int(p_anim.get_sprite_frames().get_frame("default", 0).get_height())/2)
	set_process_input(true)

#warning-ignore:unused_argument
func _physics_process(delta):
	var left_collider_check = $left_detect.get_collider()
	var right_collider_check = $right_detect.get_collider()
	if(right_collider_check):
		if(right_collider_check.get_groups().has("ground") and right_collider_check.get_parent().get_inclose() == true):
			print("right_collider_check.get_constant_linear_velocity(): ", right_collider_check.get_constant_linear_velocity())
			linear_velocity.x += right_collider_check.get_constant_linear_velocity().x * slide_motion
	if(left_collider_check):
		if(left_collider_check.get_groups().has("ground") and left_collider_check.get_parent().get_inclose() == true):
			linear_velocity.x += left_collider_check.get_constant_linear_velocity().x * slide_motion


func _input(event): # This handles any input for player control
	if event.is_action_pressed("move_left"):
		linear_velocity.x = -150
	if event.is_action_pressed("move_right"):
		linear_velocity.x = 150
	if event.is_action_pressed("Jump") or jump == true:
		if gd.is_colliding():
			if(Global.get_player_dead() == false):
				p_anim.set_animation("Jump_up")
				if(side_move == true):
					if Input.get_accelerometer().x < 0:
						linear_velocity.x = -150
					if Input.get_accelerometer().x > 0:
						linear_velocity.x = 150
				linear_velocity.y = -500 #fixes the jump michanics
				#apply_impulse(offset, impulse)
	jump = false

func _on_Global_player_dead():
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
