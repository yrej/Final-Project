extends Area3D

func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body.has_method("port"):
			body.port("res://level.tscn")
