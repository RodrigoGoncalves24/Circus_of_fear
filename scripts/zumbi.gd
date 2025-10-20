extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var wall_detector: RayCast2D = $RayCast2D
@onready var zumbi = $AnimatedSprite2D

const speed = 100.0
var direction := 1

func _physics_process(delta: float):
		
	if is_on_wall():
		direction *= -1
		wall_detector.scale.x *= -1
	
	if direction == 1:
		zumbi.flip_h = false
	else:
		zumbi.flip_h = true
		
	
	velocity.x = direction * speed
	move_and_slide()
