extends Node2D

@onready var scene_limit_next: Marker2D
@onready var scene_limit_prev: Marker2D
@onready var player: CharacterBody2D = $Crianca
@onready var level: Node

@onready var level_cleared = false
@onready var current_level = 1

func  _ready() -> void:
	var qtd_filhos = get_child_count()
	# Assumindo que o level é SEMPRE o último nodo da cena!
	level = get_child(qtd_filhos-1)
	player = level.get_node("Crianca")
	if level.has_node("SceneLimitN"):
		scene_limit_next = level.get_node("SceneLimitN")
		print(scene_limit_next)
	if level.has_node("SceneLimitP"):
		scene_limit_prev = level.get_node("SceneLimitP")
		print(scene_limit_prev)
	print(player)
			
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("level_cleared"):
		switch_level_status(!level_cleared)
	if scene_limit_next == null && scene_limit_prev == null:
		# TODO Verificar se vai ser possível ou necessário voltar fases
		# Proxima cena/fase
		if level.has_node("SceneLimitN"):
			scene_limit_next = level.get_node("SceneLimitN")
			print(scene_limit_next)
		# Cena/fase anterior
		if level.has_node("SceneLimitP"):
			scene_limit_prev = level.get_node("SceneLimitP")
			print(scene_limit_prev)
		player = level.get_node("Crianca")
		print(player)
	if level_cleared:
		# Se a fase foi finalizada, pode passar pra proxima
		if scene_limit_next != null && player.position.x > scene_limit_next.position.x:
			call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(1)) + ".tscn")
			print("Level: " + str(current_level))
		if scene_limit_prev != null && player.position.x < scene_limit_prev.position.x:
			call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(-1)) + ".tscn")
			print("Level: " + str(current_level))
				
func switch_level_status(new_status: bool):
	level_cleared = new_status
	
func switch_level(qtd: int) -> int:
	# Aumenta ou diminui o contador de fases e reseta a flag de fase finalizada
	current_level += qtd
	if qtd < 0:
		level_cleared = false
	return current_level

func goto_scene(path: String):
	var qtd_filhos = get_child_count()
	print("Total children: "+str(qtd_filhos))
	var world := get_child(qtd_filhos-1)
	world.free()
	var new_scene : PackedScene = ResourceLoader.load(path)
	level = new_scene.instantiate()
	scene_limit_next = null # indica a troca de cena
	scene_limit_prev = null
	get_tree().get_root().get_child(0).add_child(level)  
