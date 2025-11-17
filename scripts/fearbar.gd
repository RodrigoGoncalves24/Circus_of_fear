extends ProgressBar

var fear = 0.0 : 
	set = _set_fear,
	get = _get_fear

func _set_fear(_new_fear):
	value = _new_fear
	
func _get_fear() -> float:
	return value
	
func _ready():
	value = fear
	$Label.hide()

func _add_fear(_new_fear):
	value += _new_fear
	if value == 100:
		$Label.show()
	else:
		$Label.hide()
