extends Area2D

@export var speed: int = 300

func _process(delta):
	position += transform.x * speed * delta
	
#Ao sair da cena, ela deixa de existir
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
