extends Area2D

@onready var anim = $AnimBalloon
@export var speed: float = 200.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	connect("body_entered", _on_body_entered)
	anim.play("default") 
	print("Projétil criado!")

func _physics_process(delta):
	if direction != Vector2.ZERO:
		position += direction * speed * delta

func _on_body_entered(body):
	if body.name == "Crianca" and body.has_method("take_damage"):
		body.take_damage()

		$CollisionShape2D.disabled = true
		anim.play("explosion")  # troca para explosão

		await anim.animation_finished  # espera a animação terminar
		queue_free()
