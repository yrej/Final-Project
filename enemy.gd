extends CharacterBody3D

@onready var nav = $NavigationAgent3D
const SPEED = 5.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _process(delta: float) -> void:
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, delta)
	move_and_slide()

func target_position(target):
	nav.target_position = (target)
