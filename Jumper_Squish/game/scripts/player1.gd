extends Area2D

onready var collision = get_node("collision")
onready var p_anim = get_node("player_anim")
onready var plat_det = get_node("platform_detect")
var ogravity = Vector2(0,4)
var jump = Vector2(0,-6)

func _ready():
	collision.shape.extents.x = int(p_anim.get_sprite_frames().get_frame("default", 0).get_height())/2
	collision.shape.extents.y = int(p_anim.get_sprite_frames().get_frame("default", 0).get_width())/2
	set_process_input(true)

func _physics_process(delta):
	self.set_position(self.position + ogravity)
	
	if self.is_monitoring():
		print("is minitorying")

func _input(event):
	print("going to try and jump")
	if event.is_action_pressed("Jump"):
		if plat_det.is_colliding():
			self.set_position(self.position + ogravity)
