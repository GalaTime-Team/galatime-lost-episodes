class_name ParedeAmarela
extends Control

#########
# READY/PROCESS
#########

@export var item : Button

signal item_pressed

func _ready() -> void:
	if Global.item_coletado:
		item.hide()

func _on_item_pressed() -> void:
	item_pressed.emit()
	item.hide()
	Global.item_coletado = true
	print("guardou")
	set_process(false)
