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

@export_category("Eventos")
@export var intro_monologue: IntroMonologue
@export var tutorial: Tutorial

const change_room_dictionary : Dictionary = {
	"amarela" : ["vermelha" , "ciano"],
	"vermelha" : ["roxo" , "amarela"],
	"ciano" : ["amarela" , "roxo"],
	"roxo" : ["ciano" , "vermelha"]
}

func _ready() -> void:
	if not Global.monologuecont:
		on_intro_monologue()
	handling_signal()
	parede_visivel(Global.sala_que_estamos)
	
########
# Monologue
########

func on_intro_monologue() -> void:
	# Visualizar
	intro_monologue.set_process(true)
	intro_monologue.show()  # Ensure it's visible when starting

func end_of_dialogue() -> void:
	opening_eyes_animation()

func opening_eyes_animation() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 1.5)
	await tween.finished
	intro_monologue.hide()
	tutorial.fade_in()


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
	intro_monologue.back_dialog.connect(end_of_dialogue)

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
