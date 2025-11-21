extends Area2D

@onready var damage = $"../damage"
@onready var hurt_timer = $"../hurtTimer"
@onready var som_dano = $"../som_dano"
@onready var som_morte = $"../som_morte"

var vida = 15

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		
		vida -= 1
		
		som_dano.play()
		damage.play("damage_to_boss")
		
		hurt_timer.start()
		await hurt_timer.timeout
		damage.play("RESET")
		
		if vida <= 0:
			som_morte.play()
			await som_morte.finished
			owner.queue_free()
