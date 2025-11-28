extends CharacterBody2D

@onready var anim = $SpriteBoss
@onready var wall_detector: RayCast2D = $RayCast2DBoss
@onready var boss = $SpriteBoss
@onready var hitbox: Area2D = $hitboxBoss
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var speed: float = 100.0
@onready var player = get_parent().get_node("Crianca")
@onready var health = 15

@onready var som_tiro = $som_tiro

# Tiro do boss
@export var projectile_scene: PackedScene
@export var shoot_interval := 1.5
var shoot_timer := 0.0

func _ready():
	hitbox.body_entered.connect(on_hitbox_body_entered)

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		# ---- Animação ----
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				boss.play("right")
			else:
				boss.play("left")
		else:
			if direction.y < 0:
				boss.play("up")
			else:
				boss.play("down")


		# ---- Sistema de tiro ----
		shoot_timer -= delta
		if shoot_timer <= 0:
			shoot_timer = shoot_interval
			shoot_projectile(direction)

func shoot_projectile(direction: Vector2):
	if projectile_scene == null:
		print("ERRO: projectile_scene não foi atribuído no Inspector!")
		return
		
	som_tiro.play()

	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)

	projectile.global_position = global_position
	projectile.direction = direction.normalized()


func on_hitbox_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage()
