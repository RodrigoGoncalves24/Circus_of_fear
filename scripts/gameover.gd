extends Control

@onready var anim_player = $ColorRect/AnimationPlayer

func _ready():
	anim_player.play("game over animation")
