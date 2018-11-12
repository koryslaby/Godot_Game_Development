extends Control

var scene = load("res://scenes/World.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Button1_button_up():
	Global.set_diff_speeds(true)
	get_tree().change_scene("res://scenes/World.tscn")


func _on_Button2_button_up():
	Global.set_diff_heights(true)
	get_tree().change_scene("res://scenes/World.tscn")


func _on_Button3_button_up():
	Global.set_collors(true)
	get_tree().change_scene("res://scenes/World.tscn")
