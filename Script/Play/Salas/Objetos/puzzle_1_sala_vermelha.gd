extends Control

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var sala : Control
@export var chave : Button

func _ready() -> void:
	if Global.puzzles["puzzle1"].completo:
		if "item_1" in Global.inventario:
			chave.hide()
		else:
			chave.show()
	set_process(false)

func _on_chave_pressed() -> void:
	chave.hide()
	Global.item_guardados("item_1","item parede amarela","chave feita de metal mas com um pouco de ferrugem")

func _on_pressed() -> void:
	if not Global.puzzles["puzzle1"].completo:
		var int_introduzido = [b1.text, b2.text, b3.text]
		if verificacao_da_solucao(int_introduzido):
			Global.puzzles["puzzle1"].completo = true
			chave.show()

func verificacao_da_solucao(int_introduzido) -> bool:
	for i in Global.puzzles["puzzle1"].solucao:
		if int_introduzido[i] != Global.puzzles["puzzle1"].solucao[i]:
			return false
	return true
