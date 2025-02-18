class_name Inventory
extends Control

@export var background: ColorRect
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer
@export var listadeitem : VBoxContainer
@export var itemCard : VBoxContainer
@export var todosOsItens : VBoxContainer
@export var Anterior : Button
@export var Proximo : Button
@export var scrolllista : VScrollBar

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

func listar_todos_os_itens() -> void:
	clear_vboxcontainer(todosOsItens)

	for itens in Global.inventario:
		var item = Global.inventario[itens]
		
		var itemNome = Label.new()
		itemNome.text = "Item: " + item.nome
		todosOsItens.add_child(itemNome)

func _on_back_pressed() -> void:
	menu_click.play()
	back_inventory_menu.emit()
	set_process(false)

func buscarChave() -> void:
	for chave in Global.inventario:
		Global.buscar_imagem_por_chave(chave)
		print(chave)

func proximaInteracao() -> void:
		if interacao < Global.inventario.size() - 1:
			interacao += 1
		else:
			interacao = 0  # Volta para o primeiro item

func anteriorInteracao() -> void:
		if interacao > 0:
			interacao -= 1
		else:
			interacao = Global.inventario.size() - 1  # Volta para o último item

func listarItemCard() -> void:
	for chave in Global.inventario:
		clear_vboxcontainer(itemCard)

		if Global.inventario.size() > 0:
			var chave_atual = Global.inventario.keys()[interacao] # Busca o item atual
			var caminho_imagem = Global.buscar_imagem_por_chave(chave_atual)
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
	if interacao >= 0 and interacao < Global.inventario.size():
		var chave_atual = Global.inventario.keys()[interacao]
		
		if chave_atual in Global.inventario: 
			atualizar_imagem_item_card(chave_atual)
			atualizar_texto_lista_item(chave_atual)

func _on_proximo_pressed() -> void:
	proximaInteracao()
	if interacao >= 0 and interacao < Global.inventario.size():
		var chave_atual = Global.inventario.keys()[interacao]
		
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
