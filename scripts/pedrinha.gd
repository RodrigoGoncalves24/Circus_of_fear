extends Area2D

@export var quantidade := 1

func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Crianca" or body.name == "crianca":
		var municao = body.get_node("municao")
		municao.add_municao(quantidade)
		queue_free()
	pass # Replace with function body.
