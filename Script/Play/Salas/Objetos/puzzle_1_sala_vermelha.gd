extends Control

@export var sala : Control
@export var chave : Button

func _ready() -> void:
	set_process(false)

func _on_chave_pressed() -> void:
	chave.hide()
	Global.item_guardados("item_1","item parede amarela","chave feita de metal mas com um pouco de ferrugem","res://Asset/Images/Inventario/chave_dourada.png")
