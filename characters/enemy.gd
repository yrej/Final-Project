extends CharacterBody3D

@onready var nav = $NavigationAgent3D
const SPEED = 5.0
var I_frame = 0.8

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _process(delta: float) -> void:
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * SPEED
	hit()
	
	velocity = velocity.move_toward(new_velocity, delta)
	move_and_slide()

func hit():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("Player"):
			var coll_p = collision.get_collider()
			if coll_p.has_method("got_hit"):
				coll_p.got_hit(40)

func target_position(target):
	nav.target_position = (target)
