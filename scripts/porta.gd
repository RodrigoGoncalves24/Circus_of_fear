extends StaticBody2D

var game: Node2D
var player: CharacterBody2D
@onready var fechada = $Fechada
@onready var aberta = $Aberta
@onready var collider = $ColisaoPorta
@onready var scene_limit = $SceneLimit

<<<<<<< HEAD
#func _ready() -> void:
	#scene_limit.connect("body_entered", Callable(self, "_on_scene_limit_entered"))
=======
func _ready() -> void:
	scene_limit.connect("body_entered", Callable(self, "_on_scene_limit_entered"))
>>>>>>> 53fdda3090b5804cd464b38e3c8bbc761fd9b255

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
<<<<<<< HEAD
#	collider.set_deferred("disabled", false)
=======
	collider.set_deferred("disabled", false)
>>>>>>> 53fdda3090b5804cd464b38e3c8bbc761fd9b255

func _on_scene_limit_entered(body):
	if game and game.level_cleared:
		game.mudar_para_proxima_fase()
