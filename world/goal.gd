extends Area2D

@onready var eventbus := Eventbus

func _on_body_entered(_body: Node2D) -> void:
	eventbus.goal_reached.emit()
