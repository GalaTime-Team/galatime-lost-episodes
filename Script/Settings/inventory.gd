class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var paredeAmarela : ParedeAmarela

signal back_inventory_menu

func _ready() -> void:
	set_process(false)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()

func existe_item() -> void:
	var button = Button.new()
	button.text = "item"
	print("funfa ou nao?")
	add_child(button)
	set_process(true)

func handle_connecting_signal() -> void:
	paredeAmarela.item_pressed.connect(existe_item)
