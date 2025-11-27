extends Node2D

@onready var level: Node
@onready var player: CharacterBody2D = $Level/Crianca
@onready var tela_pause: Control = $UI/Game_Paused
@onready var current_level : int = 1
@onready var max_level : int = 4
@onready var porta: StaticBody2D

@export var monsters_count : int = 0
@export var player_health : int = 5

func _ready() -> void:
	var qtd_filhos = get_child_count()
	level = get_child(qtd_filhos-1)
	player = level.get_node("Crianca")
	tela_pause.hide()
	if level.get_node("Cenario").has_node("Porta"):
		porta = level.get_node("Cenario").get_node("Porta")
	
func _physics_process(delta: float) -> void:
	monsters_count = get_tree().get_nodes_in_group("monstros").size()
	
	if porta and (monsters_count == 0 or Input.is_action_just_pressed("level_cleared")): 
		porta.toggle_level_status(true)
	
	if Input.is_action_just_pressed("pause") and get_tree().paused:
		unpause()
	elif Input.is_action_just_pressed("pause"):
		pause()
	
func pause():
	get_tree().paused = true
	tela_pause.show()
	
func unpause():
	get_tree().paused = false
	tela_pause.hide()
		
func proxima_fase():
	call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(1)) + ".tscn")
	print("Level: " + str(current_level))
	
func fase_anterior():
	call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(-1)) + ".tscn")
	print("Level: " + str(current_level))

func switch_level(qtd: int) -> int:
	current_level += qtd
	return current_level

func goto_scene(path: String):
	var qtd_filhos = get_child_count()
	var world := get_child(qtd_filhos-1)
	world.free()
	var new_scene : PackedScene = ResourceLoader.load(path)
	level = new_scene.instantiate()
	#get_tree().get_root().get_child(0).add_child(level)
	add_child(level)
	player = level.get_node("Crianca")
	if level.get_node("Cenario").has_node("Porta"):
		porta = level.get_node("Cenario").get_node("Porta")
