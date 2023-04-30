extends Node

@onready var line: Line2D = $Line2D
@onready var timer: Timer = $NextPointTimer

func _ready():
	line.add_point(get_parent().global_position)
	
func _on_next_point_timer_timeout():
	if line.get_point_count() < 100:
		line.add_point(get_parent().global_position)
		return
	var next_point = get_parent().global_position
	var prev_point = line.get_point_position(0)
	if next_point != prev_point:
		line.add_point(next_point)
		line.remove_point(0)
