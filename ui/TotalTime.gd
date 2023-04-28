extends Label

var time_in_secs := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_in_secs += delta
	var time = snappedf(time_in_secs, 0.001)
	
	var millis = fmod(time * 1000, 1000)
	var seconds = fmod(time, 60)
	var minutes = fmod(time / 60, 60)
	
	# returns a string with the format "MM:SS:MMM"
	text = "%02d:%02d:%03d" % [minutes, seconds, millis]
