extends Control

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var sala : Control
@export var papel : Button

func _ready() -> void:
	if Global.puzzles["puzzle1"].completo:
		if "item_2" in Global.inventario:
			papel.hide()
		else:
			papel.show()
	
	set_process(false)


func _on_papel_pressed() -> void:
	papel.hide()
	Global.item_guardados("item_2","item parede azul","Um papel que contem um mapa","res://Asset/Images/Inventario/papiro.png")

func _on_pressed() -> void:
	if not Global.puzzles["puzzle1"].completo:
		var int_introduzido = [b1.text, b2.text, b3.text]
		if verificacao_da_solucao(int_introduzido):
			Global.puzzles["puzzle1"].completo = true
			papel.show()

func verificacao_da_solucao(int_introduzido) -> bool:
	for i in Global.puzzles["puzzle1"].solucao:
		if int_introduzido[i] != Global.puzzles["puzzle1"].solucao[i]:
			return false
	return true
