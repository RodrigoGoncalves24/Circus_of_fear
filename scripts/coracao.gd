extends Area2D

@export var quantidade := 1

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Crianca" or body.name == "crianca":
		var coletou = body.add_vida(quantidade)

		if coletou:
			_sumir()

func _sumir():
	var tw = create_tween()
	tw.tween_property(self, "scale", Vector2.ZERO, 0.3)
	await tw.finished
	queue_free()
