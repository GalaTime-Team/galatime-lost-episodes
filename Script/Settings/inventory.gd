class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

signal back_inventory_menu

func _ready() -> void:
	set_process(false)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)


func _on_back_mouse_entered() -> void:
	menu_hover.play()
