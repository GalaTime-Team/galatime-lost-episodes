extends Control

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var sala : Control

func _ready() -> void:
	set_process(false)


func _on_pressed() -> void:
	if not Global.puzzles["puzzle1"].completo:
		var int_introduzido = [b1.text, b2.text, b3.text]
		if verificacao_da_solucao(int_introduzido):
			Global.puzzles["puzzle1"].completo = true

func verificacao_da_solucao(int_introduzido) -> bool:
	for i in Global.puzzles["puzzle1"].solucao:
		if int_introduzido[i] != Global.puzzles["puzzle1"].solucao[i]:
			return false
	return true
