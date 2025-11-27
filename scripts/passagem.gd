extends Area2D

@onready var game: Node2D = get_tree().root.get_node("Game")

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: CharacterBody2D) -> void:
	if game:
		Global.last_used = "passagem"
		game.fase_anterior()
