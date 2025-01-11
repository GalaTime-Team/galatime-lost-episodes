class_name ParedeAmarela
extends Control

#########
# READY/PROCESS
#########

@export var item : Button

signal item_pressed

func _ready() -> void:
	pass

func _on_item_pressed() -> void:
	Global.item_guardados("item_1","item parede amarela","chave feita de metal mas com um pouco de ferrugem")

func _on_item_2_pressed() -> void:
	Global.item_guardados("item_2","item super rare","chave dourada brilhante")
