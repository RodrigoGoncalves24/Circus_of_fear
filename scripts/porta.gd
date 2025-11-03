extends StaticBody2D

@onready var game: Node2D = get_tree().root.get_node("Game")
@onready var player: CharacterBody2D
@onready var fechada = $Fechada
@onready var aberta = $Aberta
@onready var collider = $ColisaoPorta
@onready var scene_limit = $SceneLimit
var scene_limit_prev

@onready var level_cleared: bool = false

func _ready() -> void:
	scene_limit.connect("body_entered", Callable(self, "_on_scene_limit_entered"))
	if $SceneLimitPrev:
		scene_limit_prev = $SceneLimitPrev
		scene_limit_prev.connect("body_entered", Callable(self, "_on_scene_limit_prev_entered"))
		
func _physics_process(delta: float) -> void:
	#if monsters_count == 0:
	if Input.is_action_just_pressed("level_cleared"):
		toggle_level_status()
	
func toggle_level_status():
	level_cleared = not level_cleared
	if level_cleared:
		abrir_porta()
	else:
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
		game.proxima_fase()

func _on_scene_limit_prev_body_entered(body: CharacterBody2D) -> void:
	print("vai voltar")
	#TODO: MOVER ESSA PARTE PARA UM NOVO SCRIPT DE "PASSAGEM" OU ALGO ASSIM
	if game:
		game.fase_anterior()
