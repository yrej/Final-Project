extends TextureProgressBar

func _physics_process(delta: float) -> void:
	value = Global_Vars.health * 100 / Global_Vars.Max_health
