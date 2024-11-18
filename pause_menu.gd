extends ColorRect

@onready var luky = $"../../"

func _on_resume_pressed() -> void:
	luky.pauseMenu()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()
