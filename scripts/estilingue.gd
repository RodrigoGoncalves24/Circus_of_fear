extends Node2D

@onready var ponto_disparo: Marker2D = $ponto_disparo
@export var disparo_cooldown: float  = 0.8 #tempo entre disparo
@onready var som_disparo = $som_disparo

const disparo = preload("res://scenes/disparo.tscn")
var pode_atirar = true

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_just_pressed("tiro"):
		som_disparo.play()
		var disparo = disparo.instantiate()
		get_tree().root.add_child(disparo)
		disparo.global_position = ponto_disparo.global_position
		disparo.rotation = rotation
		
		pode_atirar = false
		await get_tree().create_timer(disparo_cooldown).timeout
		pode_atirar = true
