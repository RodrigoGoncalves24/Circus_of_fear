extends CharacterBody2D

@export var speed = 300.0
@export var cena_disparo: PackedScene = preload("res://scenes/disparo.tscn")
@export var disparo_cooldown: float  = 0.3 #tempo entre disparo
@onready var sprite = $AnimatedSprite2D
@onready var pontoDisparo = $PontoDisparo
var pode_atirar = true


func animate():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		
func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func move_8way(delta):
	get_8way_input()
	animate()
	move_and_slide()
	
func tiro():
	var bala = cena_disparo.instantiate()
	get_parent().add_child(bala)
	bala.global_position = pontoDisparo.global_position
	bala.direction = Vector2.RIGHT
		
	pode_atirar = false
	await get_tree().create_timer(disparo_cooldown).timeout
	pode_atirar = true
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tiro") and pode_atirar:
		tiro()
	
func _physics_process(delta):
	move_8way(delta)
