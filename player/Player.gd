extends CharacterBody2D


const SPEED = 100.0
const HORIZONTAL_SPEED = 50.0
const MAX_VERTICAL_SPEED = 1000.0
const BRAKE_STRENGTH = 3.0
const PUSH_STRENGTH = 50.0
const acceleration_cooldown = 0.7

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var acceleration_timer = acceleration_cooldown + 1.0 # start with cooldown expired

func _physics_process(delta):
	acceleration_timer += delta

	# add gravity to simulate sliding down the slope.
	velocity.y += gravity * delta

	# if breaking, slow down the vertical speed.
	if Input.is_action_pressed("brake"):
		velocity.y = move_toward(velocity.y, 0, BRAKE_STRENGTH)
		
	if Input.is_action_just_pressed("accelerate") and acceleration_timer > acceleration_cooldown:
		velocity.y = move_toward(velocity.y, MAX_VERTICAL_SPEED, PUSH_STRENGTH)
		acceleration_timer = 0.0

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * HORIZONTAL_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, HORIZONTAL_SPEED)

	move_and_slide()

