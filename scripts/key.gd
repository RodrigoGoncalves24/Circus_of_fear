extends Area2D
@onready var anim = $AnimatedSprite2D

func _ready():
	connect("body_entered", _on_body_entered)
	anim.play("key_moving")

func _on_body_entered(body):
	if body.name == "Crianca":  
		get_tree().change_scene_to_file("res://scenes/vitoria.tscn")
