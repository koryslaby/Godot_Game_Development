extends KinematicBody2D

onready var collision = get_node("Brick_collision")
onready var image = get_node("Brick_image")
var size = Vector2()

func _ready():
	add_to_group("base")
	var texture = image.get_texture()
	size.x = texture.get_height()
	size.y = texture.get_width()
	collision.get_shape().set_extents(size)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
