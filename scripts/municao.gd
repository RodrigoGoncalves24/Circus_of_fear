extends Node

signal mudanca_municao(novo_valor)

@export var MAX_MUNICAO := 10
var municao := 5

func add_municao(count: int):
	municao += count
	if municao  > MAX_MUNICAO:
		municao = MAX_MUNICAO
		
	emit_signal("mudanca_municao", municao)

func usa_municao():
	if municao <= 0:
		return false
	municao -= 1
	emit_signal("mudanca_municao", municao)
	return true
