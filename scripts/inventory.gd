extends Node2D

func _ready():
	var municao = get_node("../../municao")
	municao.connect("mudanca_municao", _on_mudanca_municao)
	_on_mudanca_municao(5)

	
func _on_mudanca_municao(value: int):
	$BulletCount.text = ": %d x" % [value]
	
