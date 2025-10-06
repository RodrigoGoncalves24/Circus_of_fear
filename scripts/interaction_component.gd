extends Area2D

var can_interact: Array[CollisionObject2D] = []
@onready var parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("interact"):
		can_interact.push_back(body)

func _on_body_exited(body: Node2D) -> void:
	if can_interact.has(body):
		can_interact.erase(body)

func _unhandled_input(event) -> void:
	if event.is_action_pressed("interact"):
		for o in can_interact:
			o.interact(parent)
			
