class_name Inventory
extends Control

@export var background: ColorRect

signal inventory_signal

func _ready() -> void:
	set_process(false)

func _on_back_pressed() -> void:
	inventory_signal.emit()
	set_process(false)

func backgroundvisible() -> void:
	if background.visible:
		background.hide()
	else:
		background.show()
