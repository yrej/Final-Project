extends Area3D

const ROT_SPEED = 100
var move_speed = 0.005
var move_y = 0
var add = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			queue_free()
			Global_Vars.coins = Global_Vars.coins + 1
			
	rotate_y(deg_to_rad(ROT_SPEED * delta))
	
	if move_y <= -0.35:
		add = true
	if move_y >= 0.35:
		add = false
	if add == true:
		move_y += move_speed
	if add == false:
		move_y -= move_speed
		
	position.y += move_y * delta * 0.5