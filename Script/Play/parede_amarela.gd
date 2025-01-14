class_name ParedeAmarela
extends Control

#########
# READY/PROCESS
#########

@export var item : TextureButton


signal item_pressed

func _ready() -> void:
	pass

@export var teste : TextureRect

func _on_item_pressed() -> void:
	Global.item_guardados("item_1","item parede amarela","chave feita de metal mas com um pouco de ferrugem","res://Asset/Images/Inventario/chave_dourada.png")
	

func _on_item_2_pressed() -> void:
	Global.item_guardados("item_2","chave dourada","chave dourada brilhante","res://Asset/Images/Inventario/chave_dourada.png")
