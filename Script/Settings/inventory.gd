class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var listadeitem : VBoxContainer

signal back_inventory_menu

func _ready() -> void:
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()

func listaritem() -> void:
	for chave in Global.inventario:
		var item = Global.inventario[chave]
		
		# Cria um Label para o nome
		var itemNome = Label.new()
		itemNome.text = "Item: " + item["nome"]
		listadeitem.add_child(itemNome)
		
		# Cria um Label para a descrição
		var itemdesc = Label.new()
		itemdesc.text = "Descrição: " + item["descricao"]
		listadeitem.add_child(itemdesc)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)
