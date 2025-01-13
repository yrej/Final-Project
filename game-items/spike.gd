extends Area3D

var I_frame = 0.8
var player = null

func hit(body: Node3D):
	if body.is_in_group("player"):
		if body.has_method("got_hit"):
			body.got_hit(40)


func _process(delta: float) -> void:
	if player != null:
		I_frame = I_frame - delta*2
		if I_frame <= 0:
			hit(player)
			I_frame = 0.8

func _on_body_entered(body: Node3D) -> void:
	player = body
	hit(player)


func _on_body_exited(body: Node3D) -> void:
	I_frame = 0.8
	player = null
