extends ColorRect

@onready var luky = $"../../"

func _on_respawn_pressed() -> void:
	get_tree().change_scene_to_file("res://Starter_area.tscn")
	Global_Vars.dead_b = false
	Global_Vars.health = Global_Vars.Max_health
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _on_quit_pressed() -> void:
	get_tree().quit()
