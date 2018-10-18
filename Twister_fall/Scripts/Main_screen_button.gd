extends Control

onready var left = get_node("Buttons/Bottom/Button_Left")
onready var right = get_node("Buttons/Bottom/Button_right")
onready var block_switch = get_node("Buttons/Top/Block_switch")
signal left_click
signal right_click
signal block_switch_click


func _ready():
	block_switch.connect("button_up", self, "on_block_switch_button_up")
	right.connect("button_up", self, "on_right_click_button_up")
	left.connect("button_up", self, "on_left_button_up")


	
func on_block_switch_button_up():
	print("clicked")
	emit_signal("block_switch_click")

func on_right_click_button_up():
	print("clicked")
	emit_signal("right_click")

func on_left_button_up():
	print("clicked")
	emit_signal("left_click")