extends Control

@export var parede_ciano : Control
@export var objetos_controler : Control

signal alterar_UI
signal alterar_objeto

func _ready() -> void:
	pass

func envia_sinal(objeto_carregado: String) -> void:
	alterar_objeto.emit(objeto_carregado, "clicar")

func carregar_objeto(objeto_carregado: String, nome: String) -> void:
	# Carrega o Objeto
	var link_objeto_a_acessar = "res://Interface/Play/Objetos/" + objeto_carregado + ".tscn"
	var objeto_a_acessar = load(link_objeto_a_acessar) as PackedScene
	
	if !objeto_a_acessar:
		print("Erro ao acessar o Objeto na cena! Nome do Objeto: " + objeto_carregado + "Resultado do \"objeto_a_acessar\": ", objeto_a_acessar)
		return
	
	var instancia_objeto = objeto_a_acessar.instantiate()
	objetos_controler.add_child(instancia_objeto)
	
	var cena_do_objeto = objetos_controler.get_child(0)
	cena_do_objeto.name = nome
	
	# Altera o UI
	alterar_UI.emit(["baixo"])
	
	cena_do_objeto.set_process(true)

func remover_objeto(objeto_carregado: String) -> void:
	if objetos_controler.get_child_count() > 0:
		for child in objetos_controler.get_children():
			if child.name == objeto_carregado:
				child.queue_free()
				break

func _on_estante_de_livros_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_painel_de_cortica_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_2_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_3_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_4_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_5_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_6_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_7_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_8_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_9_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)

func _on_estante_de_livros_10_pressed(objeto_carregado: String) -> void:
	envia_sinal(objeto_carregado)
