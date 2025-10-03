extends Node2D

@export var speed: float = 500.0
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction *speed *delta

func _on_body_entered(body):
	queue_free() #Faz o disparo desaparecer após colidir
	
	
