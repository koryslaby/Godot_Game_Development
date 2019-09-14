extends Control


func _ready():
	pass


func _on_Start_Button_button_up():
	print(get_tree().change_scene("res://scenes/Menu_Screen.tscn"))


func _on_TextureButton_button_up():
	get_tree().change_scene(("res://scenes/Settings.tscn"))
