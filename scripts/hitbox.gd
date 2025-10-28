extends Area2D

@onready var damage = $"../damage"
@onready var hurt_timer = $"../hurt_timer"

var vida = 3

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		
		vida -= 1
		
		damage.play("damage_to_zombie")
		hurt_timer.start()
		await hurt_timer.timeout
		damage.play("RESET")
		
		if vida <= 0:
			owner.queue_free()
