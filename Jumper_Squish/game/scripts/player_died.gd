extends PopupMenu


func _ready():
	pass # Replace with function body.


func _on_MenuButton_button_up():
	print(get_tree().change_scene("res://scenes/Menu_Screen.tscn"))
