extends Area2D

@onready var game: Node2D = get_tree().root.get_node("Game")

func _on_body_entered(body: CharacterBody2D) -> void:
	print("vai voltar")
	if game:
		game.fase_anterior()
