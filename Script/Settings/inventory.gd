class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var paredeAmarela : ParedeAmarela

const itemColection: Dictionary = { 
	"nome_item": "Chave", 
	"descricao_item": "123" 
}

signal back_inventory_menu

func _ready() -> void:
	handle_connecting_signal()
	set_process(false)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()

func existe_item() -> void:
	print(itemColection["nome_item"])
	print(itemColection["descricao_item"])
	set_process(true)

func handle_connecting_signal() -> void:
	paredeAmarela.item_pressed.connect(existe_item)
