extends CharacterBody2D

@export var speed = 300.0
@onready var sprite = $AnimatedSprite2D

func get_way_input():
	var input_direction = Input.get_vector("Left", "Rigth", "Up", "Down")
	velocity = input_direction * speed

func animate():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()

func move_away(delta):
	get_way_input()
	animate()
	move_and_slide()
	
func _physics_process(delta):
	move_away(delta)
