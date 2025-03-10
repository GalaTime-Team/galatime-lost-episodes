class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var itemCardNomeEdescricao : VBoxContainer
@export var itemCardImagem : VBoxContainer
@export var listaItem : VBoxContainer
@export var scrolllista : VScrollBar

var interacao : int = 0

signal back_inventory_menu

func _ready() -> void:
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()

func listar_item_nome(chave_atual: String) -> void:
	var item = Global.inventario[chave_atual]

	### Cria um Label para o nome
	var itemNome = Label.new()
	itemNome.text = "Item: " + item.nome

	itemCardNomeEdescricao.add_child(itemNome)

func listar_item_descricao(chave_atual: String) -> void:
	var item = Global.inventario[chave_atual]

	var itemdescricao = Label.new()
	itemdescricao.text = "Descrição: " + item.descricao

	itemCardNomeEdescricao.add_child(itemdescricao)

func listar_item_imagem(chave_atual: String) -> void:
	if Global.inventario.size() > 0:
		var caminho_imagem = Global.inventario[chave_atual].imagem
		var imagem_a_acessar = TextureRect.new()

		imagem_a_acessar.texture = load(caminho_imagem) as Texture2D

		itemCardImagem.add_child(imagem_a_acessar)

func listar_item_card(chave_atual: String = "") -> void:
	if Global.inventario.size() > 0:
		if chave_atual == "":
			chave_atual = Global.inventario.keys()[0]
			
		clear_vboxcontainer(itemCardImagem)
		clear_vboxcontainer(itemCardNomeEdescricao)

		listar_item_imagem(chave_atual)
		listar_item_nome(chave_atual)
		listar_item_descricao(chave_atual)
	else:
		pass

func listar_nome_itens() -> void:
	clear_vboxcontainer(listaItem)

	for chave in Global.inventario.keys():
		var item = Global.inventario[chave]

		var itemNome = Button.new()
		itemNome.text = item.nome
		itemNome.pressed.connect(self._on_item_button_pressed.bind(chave))
		listaItem.add_child(itemNome)

func _on_item_button_pressed(chave_precionada: String) -> void:
	listar_item_card(chave_precionada)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)

func clear_vboxcontainer(vbox):
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()
