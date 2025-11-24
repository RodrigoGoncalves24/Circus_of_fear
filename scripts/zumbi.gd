extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var wall_detector: RayCast2D = $RayCast2D
@onready var zumbi = $AnimatedSprite2D
@onready var hitbox: Area2D = $hitbox
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var speed: float = 100.0
@onready var player = get_parent().get_node("Crianca")
@onready var damage = $damage
@onready var som_dano = $som_dano
@onready var hurt_timer = $hurt_timer
@onready var is_dead = false
@onready var health = 5
	
func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed;
		move_and_slide()
		
		if abs(direction.x) > abs(direction.y):
			zumbi.play("rigth")
			if direction.x > 0:
				zumbi.flip_h = false
			elif direction.x < 0:
				zumbi.flip_h = true
		elif direction.y < 0:
			zumbi.play("up")
		else:
			zumbi.play("down")

func _ready():
	hitbox.body_entered.connect(on_hitbox_body_entered)

func on_hitbox_body_entered(body: Node2D):
	if is_dead:
		return
	
	if health > 0:
		health -= 1
		damage.play("damage to player")
		som_dano.play()
		hurt_timer.start()
		await hurt_timer.timeout
		damage.play("RESET")
			
	if health <= 0:
		is_dead = true
