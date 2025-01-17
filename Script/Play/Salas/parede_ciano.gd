extends Control

@export var parede_ciano : Control
@export var objetos_controler : Control

var objetos_cena_link: Dictionary = {
	"puzzle2" : "puzzle2-Sala_azul"
}

signal alterar_UI_paredeCiano

func _ready() -> void:
	pass

func _on_button_pressed(objeto_carregado: String) -> void:
	# Carrega o Objeto
	var link_objeto_a_acessar = "res://Interface/Play/Objetos/" + objetos_cena_link[objeto_carregado] + ".tscn"
	var objeto_a_acessar = load(link_objeto_a_acessar) as PackedScene
	
	Global.adicionar_sala_ao_historico(objeto_carregado)
	
	if !objeto_a_acessar:
		print("Erro ao acessar o Objeto na cena! Nome do Objeto: " + objeto_carregado + "Resultado do \"objeto_a_acessar\": ", objeto_a_acessar)
		return
	
	var instancia_objeto = objeto_a_acessar.instantiate()
	objetos_controler.add_child(instancia_objeto)
	
	var cena_do_objeto = objetos_controler.get_child(0)
	
	# Altera o UI
	alterar_UI_paredeCiano.emit(["baixo"])
	
	cena_do_objeto.set_process(true)

func remover_objeto() -> void:
	if objetos_controler.get_child_count() > 0:
		objetos_controler.get_child(0).queue_free()
