extends Control

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_controles.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
