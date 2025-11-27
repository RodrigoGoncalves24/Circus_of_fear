extends CharacterBody2D

@onready var anim = $SpriteBoss
@onready var wall_detector: RayCast2D = $RayCast2DBoss
@onready var boss = $SpriteBoss
@onready var hitbox: Area2D = $hitboxBoss
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var speed: float = 100.0
@onready var player = get_parent().get_node("Crianca")
@onready var health = 15
	
func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed;
		move_and_slide()
		
		if direction.x > 0:
			boss.play("right")
		elif direction.x < 0:
			boss.play("left")
		elif direction.y < 0:
			boss.play("up")
		else:
			boss.play("down")
			
func _ready():
	hitbox.body_entered.connect(on_hitbox_body_entered)

func on_hitbox_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		# Chama a função take_damage() no script do jogador
		body.take_damage()
