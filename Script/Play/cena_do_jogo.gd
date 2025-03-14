class_name CenaDoJogo
extends Control

@export_category("Audio")
@export var BG_Jogo: AudioStreamPlayer
@export var pause_menu: PauseMenu

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
	"amarela" : {"esquerda": "vermelha" ,"direita": "ciano", "cima": "vazio"},
	"vermelha" : {"esquerda": "roxo" ,"direita": "amarela", "cima": "vazio"},
	"ciano" : {"esquerda": "amarela" ,"direita": "roxo", "cima": "vazio"},
	"roxo" : {"esquerda": "ciano" ,"direita": "vermelha", "cima": "vazio"}
}

func _ready() -> void:
	if not Global.monologuecont:
		on_intro_monologue()
	else:
		play_bgmusic()
	handling_signal()
	parede_visivel(Global.sala_que_estamos())



########
# Monologue
########

func on_intro_monologue() -> void:
	# Visualizar
	intro_monologue.set_process(true)
	intro_monologue.show()  # Ensure it's visible when starting

func end_of_dialogue() -> void:
	opening_eyes_animation()

func play_bgmusic() -> void:
	if not BG_Jogo.playing:
		BG_Jogo.play_music()

func pause_bgmusic() -> void:
	BG_Jogo.stop()

func opening_eyes_animation() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 1.5)
	await tween.finished
	intro_monologue.hide()
	tutorial.fade_in()
	  # Parar qualquer execução anterior e ativar a permissão para tocar música
	play_bgmusic()


########
# Transição
########

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

func handling_signal() -> void:
	botao_UI.sinal_direcao.connect(mudar_sala)
	intro_monologue.back_dialog.connect(end_of_dialogue)
	parede_vermelha.alterar_UI.connect(botoes_visivel)
	parede_ciano.alterar_UI.connect(botoes_visivel)
	parede_amarela.alterar_UI.connect(botoes_visivel)
	#pause_menu.pause_music.connect()

# Recebe a direção do movimento
func mudar_sala(direcao: String) -> void:
	if direcao == "baixo":
		if Global.sala_que_estamos() in "vazio":
			parede_esconder(Global.sala_que_estamos())
			parede_visivel(Global.sala_antecedente())
		else:
			match Global.sala_antecedente():
				"amarela":
					parede_amarela.remover_objeto()
				"vermelha":
					parede_vermelha.remover_objeto()
				"ciano":
					parede_ciano.remover_objeto()
				"roxo":
					pass
				_:
					print("Erro, ")
		Global.retroceder_sala()
	else:
		parede_visivel(change_room_dictionary[Global.sala_que_estamos()][direcao])
		parede_esconder(Global.sala_que_estamos())
		Global.adicionar_sala_ao_historico(change_room_dictionary[Global.sala_que_estamos()][direcao])
	
	definir_visibilidade_botoes()

func definir_visibilidade_botoes() -> void:
	if Global.sala_que_estamos() in ["amarela", "vermelha", "ciano", "roxo"]:
		botoes_visivel(["cima", "direita", "esquerda"])
	else:
		botoes_visivel(["baixo"])

# Recebe as direções que se pode ir
func botoes_visivel(direcao: Array) -> void:
	# CIMA
	if "cima" in direcao:
		cima.show()
	else:
		cima.hide()
	
	# DIREITA
	if "direita" in direcao:
		direita.show()
	else:
		direita.hide()
	
	# BAIXO
	if "baixo" in direcao:
		baixo.show()
	else:
		baixo.hide()
	
	# ESQUERDA
	if "esquerda" in direcao:
		esquerda.show()
	else:
		esquerda.hide()
