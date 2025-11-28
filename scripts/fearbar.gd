extends ProgressBar

@onready var player : CharacterBody2D = get_parent().get_parent()
@onready var timer : Timer = $Timer

@export var isWithBoss : bool = false :
	set(value): isWithBoss = value
	get: return isWithBoss

func _ready():
	value = 0.0
	$Label.hide()
	
func _process(delta: float) -> void:
	if isWithBoss:
		value = max_value
		player.speed = 180
		$Label.show()

func update_fear(new_value = step):
	if isWithBoss:
		return
		
	value += new_value
	player.speed -= new_value
	if value == max_value:
		$Label.show()
	else:
		$Label.hide()
	print("value: " + str(value) + " speed: " + str(player.speed))
	
	await get_tree().create_timer(5.0).timeout
	restore_fear()
	
func restore_fear():
	value -= step
	player.speed += step
	$Label.hide()

func get_fear() -> float:
	return value
