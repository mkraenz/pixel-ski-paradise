extends Control

@onready var eventbus := Eventbus

func _ready():
	visible = false
	eventbus.connect('goal_reached', _on_goal_reached)

func _on_goal_reached():
	visible = true

