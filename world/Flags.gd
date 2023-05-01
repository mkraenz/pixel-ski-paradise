@tool
extends Area2D

var BlueFlagTexture = preload("res://world/flags/BlueFlag.tres")
var RedFlagTexture = preload("res://world/flags/RedFlag.tres")

@export_enum("red", "blue") var color := "red":
	get:
		return color
	set(value):
		if value != color:
			color = value
			_maybe_set_to_blue_flag()

@onready var eventbus := Eventbus
@onready var left_flag := $LeftFlag
@onready var right_flag := $RightFlag

func _ready() -> void:
	_maybe_set_to_blue_flag()

func _maybe_set_to_blue_flag() -> void:
	if not left_flag or not right_flag:
		return
	if color == "blue":
		left_flag.texture = BlueFlagTexture
		right_flag.texture = BlueFlagTexture
	elif color == 'red':
		left_flag.texture = RedFlagTexture
		right_flag.texture = RedFlagTexture

func _on_body_entered(_body):
	eventbus.flag_passed.emit()
