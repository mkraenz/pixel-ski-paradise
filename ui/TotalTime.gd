extends Label

var time_in_secs := 0.0
var final_time_in_secs := -1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_in_secs += delta
	update_text(time_in_secs)
	
func update_text(given_time: float) -> void:
	var time = snappedf(given_time, 0.001)
	
	var millis = fmod(time * 1000, 1000)
	var seconds = fmod(time, 60)
	var minutes = fmod(time / 60, 60)
	# format "MM:SS:MMM"
	text = "%02d:%02d:%03d" % [minutes, seconds, millis]

func _on_goal_body_entered(_body) -> void:
	print("RECEIVED GOAL AREA ENTERED")
	final_time_in_secs = time_in_secs
	update_text(final_time_in_secs)
	set_process(false)
