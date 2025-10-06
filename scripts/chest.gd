extends StaticBody2D

@export var items: Dictionary[InventoryItem, int] = {}
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var item_start_pos: Vector2 = $ItemStartPos.position
@onready var item_end_pos: Vector2 = $ItemEndPos.position

var is_open: bool = false 

func interact(interacter: Node2D) -> void:
	if is_open: return
	is_open = true
	animations.play("open") 
	await animations.animation_finished
	spawn_and_collect(interacter)
	
func spawn_and_collect(interacter: Node2D) -> void:
	for i: InventoryItem in items:
		for a in range(items[i]):
			var sprite := Sprite2D.new()
			sprite .texture = i.texture
			sprite.position = item_start_pos
			add_child(sprite)
			
			var tween = create_tween()
			tween.tween_property(sprite, "position", item_end_pos, 0.3)
			await tween.finished
