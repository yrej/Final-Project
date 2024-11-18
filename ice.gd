extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("on_ice"):
		body.on_ice()


func _on_body_exited(body: Node3D) -> void:
	if body.has_method("on_floor"):
		body.on_floor()
