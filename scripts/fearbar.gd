extends ProgressBar

@onready var player : CharacterBody2D = get_parent().get_parent()
@onready var timer : Timer = $Timer

func _ready():
	value = 0.0
	$Label.hide()
	
func update_fear():
	value += step
	player.speed -= step
	if value == max_value:
		$Label.show()
	else:
		$Label.hide()
	
	await get_tree().create_timer(5.0).timeout
	restore_fear()
	
func restore_fear():
	value -= step
	player.speed += step
	$Label.hide()

func get_fear() -> float:
	return value
