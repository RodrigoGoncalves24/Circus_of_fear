extends CharacterBody2D

@export var speed = 300.0
@export var cena_disparo: PackedScene = preload("res://scenes/disparo.tscn")
@onready var sprite = $AnimatedSprite2D
@onready var damage = $damage
@onready var hurt_timer = $hurt_timer
@onready var som_dano = $som_dano
@onready var som_morte = $som_morte
#Movimentação da criança
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
	

#Direções da movimentação
func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func move_8way(delta):
	get_8way_input()
	animate()
	move_and_slide()
	
func _physics_process(delta):
	move_8way(delta)

var hearts_list : Array[TextureRect]
var health = 5
var is_dead = false # Variável para evitar chamadas de dano/morte após o jogador morrer

func _ready() -> void:
	var hearts_parent = $health_bar/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)
	# Garante que a barra de vida inicial esteja correta
	update_heart_display()

func take_damage():
	# Impede que o jogador sofra mais dano se já estiver morto
	if is_dead:
		return
	
	if health > 0:
		health -= 1
		damage.play("damage to player")
		som_dano.play()
		update_heart_display()
		hurt_timer.start()
		await hurt_timer.timeout
		damage.play("RESET")
	
	if health <= 0:
		die()

func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
	
func die():
	is_dead = true
	print("O jogador morreu!")
	som_morte.play()  
	await som_morte.finished  
	Input.set_custom_mouse_cursor(load("res://textures/pointer.png"))
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")
