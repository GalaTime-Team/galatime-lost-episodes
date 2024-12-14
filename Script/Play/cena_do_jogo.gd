class_name CenaDoJogo
extends Control

@export_category("Paredes")
@export var parede_amarela: Control
@export var parede_vermelha: Control
@export var parede_ciano: Control
@export var parede_roxo: Control
@export var parede_vazio: Control

@export_category("Botões")
@export var botao_UI: Control
@export var esquerda: TextureButton
@export var direita: TextureButton
@export var cima: TextureButton
@export var baixo: TextureButton

const change_room_dictionary : Dictionary = {
	"amarela" : ["vermelha" , "ciano"],
	"vermelha" : ["roxo" , "amarela"],
	"ciano" : ["amarela" , "roxo"],
	"roxo" : ["ciano" , "vermelha"]
}

func _ready() -> void:
	handling_signal()
	parede_visivel(Global.sala_que_estamos)

func parede_visivel(parede: String) -> void:
	match parede:
		"amarela":
			parede_amarela.show()
		"vermelha":
			parede_vermelha.show()
		"ciano":
			parede_ciano.show()
		"roxo":
			parede_roxo.show()
		"vazio":
			parede_vazio.show()
		_:
			print("Error! Parede visi'vel")

func parede_esconder(parede: String) -> void:
	match parede:
		"amarela":
			parede_amarela.hide()
		"vermelha":
			parede_vermelha.hide()
		"ciano":
			parede_ciano.hide()
		"roxo":
			parede_roxo.hide()
		"vazio":
			parede_vazio.hide()
		_:
			print("Error! Parede escondida")

func handling_signal() -> void:
	botao_UI.sinal_direcao.connect(mudar_sala)

func mudar_sala(direcao: String) -> void:
	match direcao:
		"esquerda":
			parede_visivel(change_room_dictionary[Global.sala_que_estamos][0])
			parede_esconder(Global.sala_que_estamos)
			Global.sala_que_estamos = change_room_dictionary[Global.sala_que_estamos][0]
		"direita":
			parede_visivel(change_room_dictionary[Global.sala_que_estamos][1])
			parede_esconder(Global.sala_que_estamos)
			Global.sala_que_estamos = change_room_dictionary[Global.sala_que_estamos][1]
		"cima":
			parede_visivel("vazio")
			parede_esconder(Global.sala_que_estamos)
		"baixo":
			parede_visivel(Global.sala_que_estamos)
			parede_esconder("vazio")
		_:
			print("Error!")
	
	botoes_visivel(direcao)

func botoes_visivel(direcao: String) -> void:
	match direcao:
		"cima":
			esquerda.hide()
			direita.hide()
			cima.hide()
			
			baixo.show()
		"baixo":
			esquerda.show()
			direita.show()
			cima.show()
			
			baixo.hide()
