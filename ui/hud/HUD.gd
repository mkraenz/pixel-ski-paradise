extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Eventbus.connect("goal_reached", hide)
