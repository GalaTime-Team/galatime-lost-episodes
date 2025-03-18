extends Control 

@export var parede_vermelha : Control 
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
