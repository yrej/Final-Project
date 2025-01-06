extends Control

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_pressed() -> void:
	SceneTransition.change_scene("res://Starter_area.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
