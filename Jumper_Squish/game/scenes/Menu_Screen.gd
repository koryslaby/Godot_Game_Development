extends Control

var scene = load("res://scenes/World.tscn")
onready var screen_size = self.get_viewport_rect().size

func _ready():
	print("screen size is: ", screen_size)
	Global.set_screen_size(screen_size)


func _on_Button1_button_up():
	Global.set_diff_speeds(true)
	get_tree().change_scene("res://scenes/World.tscn")


func _on_Button2_button_up():
	Global.set_diff_heights(true)
	get_tree().change_scene("res://scenes/World.tscn")


func _on_Button3_button_up():
	Global.set_collors(true)
	get_tree().change_scene("res://scenes/World.tscn")
