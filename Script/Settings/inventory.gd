class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var listadeitem : VBoxContainer
@export var itemCard : VBoxContainer
@export var Anterior : Button
@export var Proximo : Button
@export var scrolllista : VScrollBar

var chavesArray : Array = []
var interacao : int = 0

signal back_inventory_menu

func _ready() -> void:
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()

func listaritem() -> void:
	for chave in Global.inventario:
		clear_vboxcontainer(listadeitem)

		var item_atual = Global.inventario.keys()[0]
		var item = Global.inventario[item_atual]

		### Cria um Label para o nome
		var itemNome = Label.new()
		itemNome.text = "Item: " + item.nome
		listadeitem.add_child(itemNome)

		### Cria um Label para o descrição
		var itemdescricao = Label.new()
		itemdescricao.text = "Descrição: " + item.descricao
		listadeitem.add_child(itemdescricao)

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
	for chave in Global.inventario:
		clear_vboxcontainer(itemCard)

		var chave_atual = chavesArray[0]
		var caminho_imagem = Global.dicionario_imagens[chave_atual]
		var imagem_a_acessar = TextureRect.new()

		imagem_a_acessar.texture = load(caminho_imagem) as Texture2D
		itemCard.add_child(imagem_a_acessar)

func clear_vboxcontainer(vbox):
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()
	for child2 in vbox.get_children():
		print("ainda tem puta nesta mrd")

################################
#Voltar e ir para o próximo item
################################

func _on_anterior_pressed() -> void:
	anteriorInteracao()
	if interacao >= 0 and interacao < chavesArray.size():
		var chave_atual = chavesArray[interacao]
		
		if chave_atual in Global.inventario: 
			atualizar_imagem_item_card(chave_atual)
			atualizar_texto_lista_item(chave_atual)

func _on_proximo_pressed() -> void:
	proximaInteracao()
	if interacao >= 0 and interacao < chavesArray.size():
		var chave_atual = chavesArray[interacao]
		
		if chave_atual in Global.inventario: 
			atualizar_imagem_item_card(chave_atual)
			atualizar_texto_lista_item(chave_atual)

func atualizar_imagem_item_card(chave_atual):
	var caminho_imagem = Global.dicionario_imagens[chave_atual]
	var imagem_a_acessar = TextureRect.new()
	imagem_a_acessar.texture = load(caminho_imagem) as Texture2D
	# Limpa o itemCard e adiciona a nova imagem
	clear_vboxcontainer(itemCard)
	itemCard.add_child(imagem_a_acessar)

func atualizar_texto_lista_item(chave_atual):
	var item = Global.inventario[chave_atual]
	var itemNome = Label.new()
	itemNome.text = "Item: " + item.nome
	var itemdescricao = Label.new()
	itemdescricao.text = "Descrição: " + item.descricao
	clear_vboxcontainer(listadeitem)
	listadeitem.add_child(itemNome)
	listadeitem.add_child(itemdescricao)
