extends Node2D

var scene_limit: Marker2D
var player: CharacterBody2D

var current_scene = null

func  _ready() -> void:
	var qtd_filhos = get_child_count()
	# Assumindo que o level é SEMPRE o último
	# nodo da cena!
	var level = get_child(qtd_filhos-1)
	player = level.get_node("Crianca")
	scene_limit = level.get_node("SceneLimit")
	print(scene_limit)
			
func _physics_process(delta: float) -> void:
	if scene_limit == null:
		scene_limit = current_scene.get_node("SceneLimit")
		player = current_scene.get_node("Crianca")
	#print(player.position.y, " ", scene_limit.position.y)
	if player.position.x > scene_limit.position.x:
		#get_tree().change_scene_to_file("res://Cenas/level_2.tscn")
		call_deferred("goto_scene", "res://scenes/level_2.tscn")
				
func goto_scene(path: String):
	var qtd_filhos = get_child_count()
	print("Total children: "+str(qtd_filhos))
	var world := get_child(qtd_filhos-1)
	world.free()
	var new_scene : PackedScene = ResourceLoader.load(path)
	current_scene = new_scene.instantiate()
	scene_limit = null # indica a troca de cena
	get_tree().get_root().get_child(0).add_child(current_scene)  
