extends Button

func _pressed() -> void:
	# game.level_cleared = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")
