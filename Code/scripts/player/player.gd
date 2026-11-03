extends CharacterBody3D

var window_move_speed: float = 400.0

#connecting to the camera in the Player Scene
@onready var camera = $Camera3D
@onready var raycast = $Camera3D/InteractionRay

#defines with object is being interacted with
var current_interactable = null

# constants (const)
const MOUSE_SENSITIVITY = 0.002
const MIN_LOOKANGLE : float = -80.0
const MAX_LOOKANGLE : float = 90.0
const SPEED = 3.0
const JUMP_VELOCITY = 4.5

#when the function starts
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump. ui_accept usually means Space or Enter keys
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# Establishing the speed of movements
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#Basically just means that players can move around
	move_and_slide()	
	
	var input_direction: float = Input.get_axis("turn_left", "turn_right")
	if input_direction != 0.0:
		# 2.0 = turn speed
		rotate_y(-input_direction * 2.0 * delta)
		

# User inputs
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp( #Limits up/down movement to 85 to -85 degrees vertically
			camera.rotation.x,
			deg_to_rad(MIN_LOOKANGLE),
			deg_to_rad(MAX_LOOKANGLE)
		)
	#needs another condition or every time "E" is pressed everything will react
	if Input.is_action_just_pressed("interact"):
		if $"../TestInteractive/Label3D".text == "Press E to interact":
			$"../TestInteractive/Label3D".text = "Congratulations! Interaction kinda works :)"
		else:
			$"../TestInteractive/Label3D".text = "Press E to interact"
			
# To do (Immediate):
# - Figure out how to do interactions on object directly in front of player
# - Locking and unlocking the mouse
