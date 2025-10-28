extends Area2D

@onready var damage = $"../damage"
@onready var hurt_timer = $"../hurt_timer"

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		damage.play("damage_to_zombie")
		hurt_timer.start()
		await hurt_timer.timeout
		damage.play("RESET")
		owner.queue_free()
