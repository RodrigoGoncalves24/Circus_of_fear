extends Node2D

var total : float = 0
const SPEED : int = 300 # pixels/segundo

func _ready() -> void:
	return

func _input(event: InputEvent) -> void:
	#print(event.as_text())
	if event.is_action_pressed("ui_right"):
		print("Right arrow!")
	
func _process(delta: float) -> void:
	return
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position.x += SPEED * delta
