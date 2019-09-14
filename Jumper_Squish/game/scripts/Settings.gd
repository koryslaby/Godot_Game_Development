extends Control





func _on_TextureButton2_button_up():
	print(get_tree().change_scene("res://scenes/Conrols.tscn"))


func _on_TextureButton_button_up():
	print(get_tree().change_scene("res://scenes/Ability.tscn"))


func _on_Home_button_up():
	print(get_tree().change_scene("res://scenes/Start_Screen.tscn"))
