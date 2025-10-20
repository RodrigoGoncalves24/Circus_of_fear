extends StaticBody2D

var game: Node2D
var player: CharacterBody2D
@onready var fechada = $Fechada
@onready var aberta = $Aberta
@onready var collider = $ColisaoPorta
@onready var scene_limit = $SceneLimit

#func _ready() -> void:
	#scene_limit.connect("body_entered", Callable(self, "_on_scene_limit_entered"))

func _physics_process(delta):
	if game and game.level_cleared:
		abrir_porta()
	else:
		fechar_porta()

func abrir_porta():
	fechada.hide()
	aberta.show()
	collider.set_deferred("disabled", true)

func fechar_porta():
	fechada.show()
	aberta.hide()
#	collider.set_deferred("disabled", false)

func _on_scene_limit_entered(body):
	if game and game.level_cleared:
		game.mudar_para_proxima_fase()
