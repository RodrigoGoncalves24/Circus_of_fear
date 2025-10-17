extends StaticBody2D

@onready var game = get_parent().get_parent().get_parent()

func _physics_process(delta: float) -> void:
	if game.level_cleared:
		self.get_node("Fechada").hide()
		self.get_node("Aberta").show()
		self.get_node("CollisionShape2D").set_deferred("disabled", true)
		#print("porta aberta")
	else:
		self.get_node("Fechada").show()
		self.get_node("Aberta").hide()
		self.get_node("CollisionShape2D").set_deferred("disabled", false)
		#print("porta fechada")
	
