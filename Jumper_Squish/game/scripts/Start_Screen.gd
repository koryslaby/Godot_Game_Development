extends Control

onready var start_button = get_node("Start_Button_Cont/Start_Button")

func _ready():
	pass


func _on_Start_Button_button_up():
	get_tree().change_scene("res://scenes/Menu_Screen.tscn")
