extends Node2D

@export var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO #Diz a direção do disparo

func _process(delta: float) -> void:
	position += direction *speed *delta

func _on_body_entered(body):
	queue_free() #Faz o disparo desaparecer após colidir
	
	
