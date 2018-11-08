extends Control

var scene = load("res://scenes/World.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Button1_button_up():
	var instanced_scene = scene.instance()
	print("when instancing scene: ", instanced_scene)
	print("scene is: ", instanced_scene)
	print("scene.get_script is: ", instanced_scene.get_script())
	print("scene.get_script.set_diff_speeds is: ", instanced_scene.get_script().set_diff_speeds(true))
	scene.get_script().set_diff_speeds(true)
	get_tree().change_scene("res://scenes/World.tscn")


func _on_Button2_button_up():
	get_tree().change_scene("res://scenes/World.tscn")


func _on_Button3_button_up():
	get_tree().change_scene("res://scenes/World.tscn")
