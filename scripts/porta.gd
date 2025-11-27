extends StaticBody2D

@onready var game: Node2D = get_tree().root.get_node("Game")
@onready var player: CharacterBody2D
@onready var fechada = $Fechada
@onready var aberta = $Aberta
@onready var collider = $ColisaoPorta
@onready var scene_limit = $SceneLimit

@onready var level_cleared: bool = false

func _ready() -> void:
	scene_limit.connect("body_entered", Callable(self, "_on_scene_limit_entered"))
	
func toggle_level_status(isOpen : bool = false):
	if isOpen:
		level_cleared = true
		abrir_porta()
	else:
		level_cleared = false
		fechar_porta()
	print("Level cleared: " + str(level_cleared))

func abrir_porta():
	fechada.hide()
	aberta.show()
	collider.set_deferred("disabled", true)

func fechar_porta():
	fechada.show()
	aberta.hide()
	collider.set_deferred("disabled", false)

func _on_scene_limit_body_entered(body: CharacterBody2D) -> void:
	if game and level_cleared:
		Global.last_used = "porta"
		game.proxima_fase()
