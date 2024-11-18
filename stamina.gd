extends TextureProgressBar

func _physics_process(delta: float) -> void:
	value = Global_Vars.stamina * 100 / Global_Vars.Max_stamina
