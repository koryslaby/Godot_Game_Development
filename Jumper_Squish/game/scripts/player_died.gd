extends PopupMenu


func _ready():
	pass # Replace with function body.



func _on_MenuButton_button_up():
	print(get_tree().change_scene("res://scenes/Menu_Screen.tscn"))


func _on_GameInfo_visibility_changed():
	var game_info = $GameInfo
	game_info.text = "Congrats! You made it to level "
	game_info.text += String(Global.get_max_level())
	game_info.text += " Your score was "
	game_info.text += String(Global.get_points())
