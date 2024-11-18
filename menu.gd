extends Control

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Starter_area.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
