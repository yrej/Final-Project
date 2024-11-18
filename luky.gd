extends CharacterBody3D

class_name Player

var curent_speed = 5.0
var friction = 15
var camera_speed = 15
var crouching_depth = -0.4
const walk_speed = 5.00
const sprint_add_speed = 3.0
const crouch_speed = 2.5
const JUMP_VELOCITY = 4.5

const mouse_sens = 0.005

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var pause_menu = $Neck/Pause_Menu
@onready var standing_collision = $standing_collision
@onready var crouching_collision = $crouch_collision
@onready var standing_ray_cast = $RayCast3D
@onready var anim = $Neck/Camera3D/HUD

@onready var Spell_slot: int = Global_Vars.Spell_slot

var direction = Vector3.ZERO
var paused = false

func _ready():
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func dead():
	Global_Vars.dead_b = true
	pause_menu.show()
	Engine.time_scale = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if !Global_Vars.dead_b:
		if !paused:
			if event is InputEventMouseMotion:
				rotate_y(-event.relative.x * mouse_sens)
				neck.rotate_x(-event.relative.y * mouse_sens)
				neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-89),deg_to_rad(89))
			if event is InputEventMouseButton:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			if Input.is_action_just_pressed("ui_cancel"):
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif paused:
			if Input.is_action_just_pressed("ui_cancel"):
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func on_ice():
	friction = 1
func on_floor():
	friction = 15
func spawn():
	anim.spawn()
func port():
	anim.port()
	
func got_hit(dmg: int):
	Global_Vars.health = Global_Vars.health - dmg

func _physics_process(delta: float) -> void:
	if Global_Vars.health <= 0:
		dead()
	# Add the gravity.
	if not is_on_floor():
		if velocity.y > 0:
			velocity += get_gravity() * delta
		if velocity.y <= 0: 
			velocity += get_gravity() * delta * 2.00

	if !Input.is_action_pressed("sprint") and Global_Vars.stamina < Global_Vars.Max_stamina:
		Global_Vars.stamina = Global_Vars.stamina + 0.25
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if !standing_ray_cast.is_colliding():
			velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Swap_spell"):
		if Global_Vars.Spell_slot == 0:
			Global_Vars.Spell_slot = 1
		else :
			Global_Vars.Spell_slot = 0
	
	if Input.is_action_pressed("sprint") and Input.is_action_pressed("crouch") and is_on_floor():
		if Global_Vars.stamina > 0:
			curent_speed = crouch_speed + sprint_add_speed
			neck.position.y = lerp(neck.position.y,crouching_depth,delta*camera_speed)
			standing_collision.disabled = true
			crouching_collision.disabled = false
			Global_Vars.stamina = Global_Vars.stamina - 1
		if Global_Vars.stamina < 1:
			curent_speed = crouch_speed
			neck.position.y = lerp(neck.position.y,crouching_depth,delta*camera_speed)
			standing_collision.disabled = true
			crouching_collision.disabled = false
	elif Input.is_action_pressed("crouch") and is_on_floor():
		curent_speed = crouch_speed
		neck.position.y = lerp(neck.position.y,crouching_depth,delta*camera_speed)
		standing_collision.disabled = true
		crouching_collision.disabled = false
	elif Input.is_action_pressed("sprint") and standing_ray_cast.is_colliding():
		if Global_Vars.stamina > 0:
			curent_speed = crouch_speed + sprint_add_speed
			neck.position.y = lerp(neck.position.y,crouching_depth,delta*camera_speed)
			standing_collision.disabled = true
			crouching_collision.disabled = false
			Global_Vars.stamina = Global_Vars.stamina - 1
		if Global_Vars.stamina < 1:
			curent_speed = crouch_speed
			neck.position.y = lerp(neck.position.y,crouching_depth,delta*camera_speed)
			standing_collision.disabled = true
			crouching_collision.disabled = false
	elif Input.is_action_pressed("sprint") and !standing_ray_cast.is_colliding():
		if Global_Vars.stamina > 0:
			curent_speed = walk_speed + sprint_add_speed
			neck.position.y = lerp(neck.position.y,0.2,delta*camera_speed)
			standing_collision.disabled = false
			crouching_collision.disabled = true
			Global_Vars.stamina = Global_Vars.stamina - 1
		if Global_Vars.stamina < 1:
			curent_speed = walk_speed
			neck.position.y = lerp(neck.position.y,0.2,delta*camera_speed)
			standing_collision.disabled = false
			crouching_collision.disabled = true
	elif !standing_ray_cast.is_colliding():
		curent_speed = walk_speed
		neck.position.y = lerp(neck.position.y,0.2,delta*camera_speed)
		standing_collision.disabled = false
		crouching_collision.disabled = true
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*friction)
	if direction:
		velocity.x = direction.x * curent_speed
		velocity.z = direction.z * curent_speed
	else:
		velocity.x = move_toward(velocity.x, 0, curent_speed)
		velocity.z = move_toward(velocity.z, 0, curent_speed)

	move_and_slide()
