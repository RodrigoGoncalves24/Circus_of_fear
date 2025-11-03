extends Control

@onready var sequence = [
	$ColorRect/w, 
	$ColorRect/a, 
	$ColorRect/s, 
	$ColorRect/d,
	$ColorRect/e, 
	$ColorRect/esc, 
	$ColorRect/mouse
	]
var current_index := 0
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = 0.5
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var key = sequence[current_index]
	_highlight_key(key)
	current_index = (current_index + 1) % sequence.size()

func _highlight_key(key):
	key.play("default")
	await get_tree().create_timer(1.0).timeout
	key.stop()

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
