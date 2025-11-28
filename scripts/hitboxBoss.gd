extends Area2D

@onready var damage = $"../damage"
@onready var hurt_timer = $"../hurt_timer"
@onready var som_dano = $"../som_dano"
@onready var som_morte = $"../som_morte"

var vida = 15
var hearts_list : Array[TextureRect]

func _ready() -> void:
	var hearts_parent = get_parent().get_node("health_bar").get_node("HBoxContainer")
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	# Garante que a barra de vida inicial esteja correta
	update_heart_display()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		
		vida -= 1
		update_heart_display()
		
		som_dano.play()
		damage.play("damage_to_boss")
		
		hurt_timer.start()
		await hurt_timer.timeout
		damage.play("RESET")
		
		if vida <= 0:
			som_morte.play()
			await som_morte.finished
			owner.queue_free()
			
func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < vida
