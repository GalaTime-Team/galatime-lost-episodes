extends Control

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var sala : Control
@export var chave : TextureButton

func _ready() -> void:
	if Global.puzzles["puzzle1"].completo:
		b1.text = Global.puzzles["puzzle1"].solucao[0]
		b2.text = Global.puzzles["puzzle1"].solucao[1]
		b3.text = Global.puzzles["puzzle1"].solucao[2]
		if "item_1" in Global.inventario:
			chave.hide()
		else:
			chave.show()
	set_process(false)

func _on_chave_pressed() -> void:
	chave.hide()
	Global.item_guardados("item_1","item parede amarela","chave feita de metal mas com um pouco de ferrugem","res://Asset/Images/Inventario/chave_dourada.png")

func _on_pressed() -> void:
	if not Global.puzzles["puzzle1"].completo:
		var int_introduzido = [b1.text, b2.text, b3.text]
		if verificacao_da_solucao(int_introduzido):
			Global.puzzles["puzzle1"].completo = true
			chave.show()
			#SaveGame.save_game()

func verificacao_da_solucao(int_introduzido) -> bool:
	for i in Global.puzzles["puzzle1"].solucao.size():
		if int_introduzido[i] != Global.puzzles["puzzle1"].solucao[i]:
			return false
	return true
