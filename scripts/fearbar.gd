extends ProgressBar

@onready var timer = $Timer
@onready var progress_bar = $ProgressBar

var fear = 0 : set = _set_fear

func _set_fear(new_fear):
	var prev_fear = fear
	fear = min(max_value, new_fear)
	value = fear
	
	if fear < prev_fear:
		timer.start()
	else:
		progress_bar.value = fear
	
func init_fear(_fear):
	fear = _fear
	max_value = fear
	value = fear
	progress_bar.max_value = fear
	progress_bar.value = fear

func _on_timer_timeout() -> void:
	progress_bar.value = fear
