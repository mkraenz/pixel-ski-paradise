extends Label

@onready var eventbus := Eventbus

var _passed_flags := 0;
@onready var _all_flags : int = get_node("/root/World/TileMap/Flags").get_child_count()

func _ready():
	eventbus.connect('flag_passed', _on_flag_passed)
	eventbus.connect('goal_reached', _update_text)

	_update_text()
	
func _on_flag_passed() -> void:
	_passed_flags += 1
	_update_text()
	
func _update_text() -> void:
	text = "%s of %s passed" % [str(_passed_flags), str(_all_flags)]