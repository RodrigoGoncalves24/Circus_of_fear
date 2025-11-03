extends Control

func _on_continuar_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_sair_pressed() -> void:
	get_tree().paused = false
	hide()
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
