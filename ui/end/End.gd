extends Control

@onready var eventbus := Eventbus
@onready var audio: AudioStreamPlayer2D = $Audio


func _ready():
	visible = false
	eventbus.connect("goal_reached", _on_goal_reached)


func _on_goal_reached():
	visible = true
	audio.play()
