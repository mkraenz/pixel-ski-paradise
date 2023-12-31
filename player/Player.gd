extends CharacterBody2D

const SPEED := 100.0
const HORIZONTAL_SPEED := 50.0
const MAX_VERTICAL_SPEED := 1000.0
const BRAKE_STRENGTH := 3.0
const END_BRAKE_STRENGTH := 50.0
const PUSH_STRENGTH := 50.0
const acceleration_cooldown := 0.7
const min_left := 15
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anims: AnimatedSprite2D = $AnimSprite
@onready var pushPoleAnimTimer: Timer = $AnimSprite/PushPoleTimer
@onready var eventbus := Eventbus

var acceleration_cooldown_timer := acceleration_cooldown + 1.0  # start with cooldown expired
var apply_delayed_acceleration = false
var input_enabled = true


func _ready() -> void:
	eventbus.connect("goal_reached", _on_goal_reached)


func _physics_process(delta) -> void:
	acceleration_cooldown_timer += delta

	# add gravity to simulate sliding down the slope.
	velocity.y += gravity * delta

	if not input_enabled:
		var brakeStrength = max(velocity.y * .15, 5.0)
		velocity.y = move_toward(velocity.y, 0, brakeStrength)
		velocity.x = 0
		move_and_slide()
		return

	# if breaking, slow down the vertical speed.
	if Input.is_action_pressed("brake"):
		velocity.y = move_toward(velocity.y, 0, BRAKE_STRENGTH)

	if apply_delayed_acceleration:
		velocity.y = move_toward(velocity.y, MAX_VERTICAL_SPEED, PUSH_STRENGTH)
		apply_delayed_acceleration = false

	if (
		Input.is_action_just_pressed("accelerate")
		and acceleration_cooldown_timer > acceleration_cooldown
	):
		acceleration_cooldown_timer = 0.0
		pushPoleAnimTimer.start()
		anims.play("push_pole")

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * HORIZONTAL_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, HORIZONTAL_SPEED)

	if position.x < min_left and velocity.x < 0:
		velocity.x = 0

	if position.x > 310 and velocity.x > 0:
		velocity.x = 0

	move_and_slide()


func _on_push_pole_timer_timeout() -> void:
	anims.play("default")
	apply_delayed_acceleration = true


func _on_goal_reached() -> void:
	input_enabled = false
