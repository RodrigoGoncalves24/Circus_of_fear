extends Node2D

@onready var level: Node = $Level
@onready var player: CharacterBody2D = level.get_node("Crianca")
@onready var pause: Control = $Game_Paused

@onready var current_level = 1

@export var monsters_count = 2

func _ready() -> void:
	pause.hide()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and get_tree().paused:
		print("UNPAUSE")
		_Unpause()
	elif Input.is_action_just_pressed("pause"):
		print("PAUSE")
		_Pause()
	
func _Pause():
	get_tree().paused = true
	pause.show()
	
func _Unpause():
	get_tree().paused = false
	pause.hide()
		
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
	print("Total children: "+str(qtd_filhos))
	var world := get_child(qtd_filhos-1)
	world.free()
	var new_scene : PackedScene = ResourceLoader.load(path)
	level = new_scene.instantiate()
	get_tree().get_root().get_child(0).add_child(level)
	
