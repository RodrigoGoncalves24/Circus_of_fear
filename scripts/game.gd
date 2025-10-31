extends Node2D

@onready var level: Node = $Level
@onready var player: CharacterBody2D = level.get_node("Crianca")

@onready var current_level = 1

@export var monsters_count = 2
	
func proxima_fase():
	call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(1)) + ".tscn")
	print("Level: " + str(current_level))
	
func fase_anterior():
	call_deferred("goto_scene", "res://scenes/level_" + str(switch_level(-1)) + ".tscn")
	print("Level: " + str(current_level))
	
func switch_level(qtd: int) -> int:
	# Aumenta ou diminui o contador de fases e reseta a flag de fase finalizada
	#if qtd > 0:
		#level_cleared = false
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
