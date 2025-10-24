extends Node2D

@onready var player: CharacterBody2D
@onready var level: Node

@onready var level_cleared: bool = false
@onready var current_level = 1

func  _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://textures/mira.png"))
	var qtd_filhos = get_child_count()
	# Assumindo que o level é SEMPRE o último nodo da cena!
	level = get_child(qtd_filhos-1)
	player = level.get_node("Crianca")
	for porta in get_tree().get_nodes_in_group("portas"):
		porta.game = self
			
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("level_cleared"):
		switch_level_status(!level_cleared)
	
func proxima_fase():
	call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(1)) + ".tscn")
	print("Level: " + str(current_level))
	
func fase_anterior():
	call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(-1)) + ".tscn")
	print("Level: " + str(current_level))
	
func switch_level_status(new_status: bool):
	level_cleared = new_status
	print("Cleared: " + str(level_cleared))
	
func switch_level(qtd: int) -> int:
	# Aumenta ou diminui o contador de fases e reseta a flag de fase finalizada
	if qtd > 0:
		level_cleared = false
	current_level += qtd
	return current_level

func goto_scene(path: String):
	var qtd_filhos = get_child_count()
	print("Total children: "+str(qtd_filhos))
	var world := get_child(qtd_filhos-1)
	world.free()
	var new_scene : PackedScene = ResourceLoader.load(path)
	level = new_scene.instantiate()
	get_tree().get_root().get_child(0).add_child(level)
	for porta in get_tree().get_nodes_in_group("portas"):
		porta.game = self
