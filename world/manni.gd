extends AnimatedSprite2D

@onready var eventbus := Eventbus


# Called when the node enters the scene tree for the first time.
func _ready():
	eventbus.connect("goal_reached", cheer)


func cheer():
	play("cheer")
