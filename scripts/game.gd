extends Node2D

var scene_limit_next: Marker2D
var scene_limit_prev: Marker2D
var player: CharacterBody2D
var porta: StaticBody2D
var level: Node

var current_level = 1
var level_cleared = false

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
	# Verificacao se a fase foi finalizada
	if Input.is_action_just_pressed("level_cleared"):
		level_cleared = !level_cleared		
		
		# TODO Levar para porta.gd
		porta = level.get_node("Cenario").get_node("Porta")
		if level_cleared:
			porta.get_node("Fechada").hide()
			porta.get_node("Aberta").show()
			porta.get_node("CollisionShape2D").set_deferred("disabled", true)
			print("porta escondida")
		else:
			porta.get_node("Fechada").show()
			porta.get_node("Aberta").hide()
			porta.get_node("CollisionShape2D").set_deferred("disabled", false)
			print("porta apareceu dnv")
			
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
				
func switch_level(qtd: int) -> int:
	# Aumenta ou diminui o contador de fases e reseta a flag de fase finalizada
	current_level += qtd
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
