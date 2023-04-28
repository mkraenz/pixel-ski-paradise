extends CharacterBody2D


const SPEED = 100.0
const HORIZONTAL_SPEED = 50.0
const MAX_VERTICAL_SPEED = 1000.0
const BRAKE_STRENGTH = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor(): # if not breaking, add gravity to simulate sliding down the slope.
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("brake"):
		velocity.y = move_toward(velocity.y, 0, BRAKE_STRENGTH)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * HORIZONTAL_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, HORIZONTAL_SPEED)

	move_and_slide()
