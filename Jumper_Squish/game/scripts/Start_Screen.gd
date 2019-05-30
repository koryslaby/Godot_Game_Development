extends Control

func _ready():
	pass


func _on_Start_Button_button_up():
#warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Menu_Screen.tscn")
