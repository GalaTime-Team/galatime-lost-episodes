class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var listadeitem : VBoxContainer
@export var itemCard : VBoxContainer

var chavesArray : Array = []
var interacao : int = 0

signal back_inventory_menu

func _ready() -> void:
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()

func listaritem() -> void:
	clear_vboxcontainer(listadeitem)
	
	for chave in Global.inventario:
		var item = Global.inventario[chave]
		
		# Cria um Label para o nome
		var itemNome = Label.new()
		itemNome.text = "Item: " + item.nome
		listadeitem.add_child(itemNome)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)

func buscarChave() -> void:
	for chave in Global.inventario:
		chavesArray.append(chave)

func proximaInteracao() -> void:
	if interacao < chavesArray.size():
		interacao += 1

func anteriorInteracao() -> void:
	if interacao >= 0:
		interacao -= 1

func listarItemCard() -> void:
	clear_vboxcontainer(itemCard)
	
	var item = Global.inventario[chavesArray[interacao]]
	
	# Cria um Label para o nome
	var itemNome = Label.new()
	itemNome.text = "Item: " + item.nome
	itemCard.add_child(itemNome)
	
	# Cria um Label para o descrição
	var itemdescricao = Label.new()
	itemdescricao.text = "Item: " + item.descricao
	itemCard.add_child(itemdescricao)

func clear_vboxcontainer(vbox):
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()
