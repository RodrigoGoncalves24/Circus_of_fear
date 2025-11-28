extends Control

@onready var anim_player = $ColorRect/AnimationPlayer

func _ready():
	anim_player.play("victory animation")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
