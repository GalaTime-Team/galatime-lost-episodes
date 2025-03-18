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
	"roxo" : {"esquerda": "ciano" ,"direita": "vermelha", "cima": "vazio"},
	"vazio" : {"esquerda": "" ,"direita": "", "cima": ""}
}

var objetos_cena_link: Dictionary = {
	"Aproximar_PostIt" : {"id_cena": "Aproximar_PostIt_Sala_amarela", "sala" : "amarela"},
	"Aproximar_trash" : {"id_cena": "Aproximar_trash_Sala_amarela", "sala" : "amarela"},
	"Aproximar_banca" : {"id_cena": "Aproximar_Banca_Sala_amarela", "sala" : "amarela"},
	"Aproximar_cookie" : {"id_cena": "Aproximar_Cookie_Sala_amarela", "sala" : "amarela"},
	"Puzzle1" : {"id_cena": "puzzle1-Sala_amarela", "sala" : "amarela"}
}

var pausado : bool = false
var posicao : float = 0.0

func _ready() -> void:
	if not Global.monologuecont:
		on_intro_monologue()
	else:
		play_bgmusic()
	
	handling_signal()
	cena_visivel(Global.sala_que_estamos(), true)

########
# Handling Signal
########

func handling_signal() -> void:
	botao_UI.sinal_direcao.connect(mudar_sala)
	intro_monologue.back_dialog.connect(end_of_dialogue)
	
	# alterar UI
	parede_amarela.alterar_UI.connect(botoes_visivel)
	parede_vermelha.alterar_UI.connect(botoes_visivel)
	parede_ciano.alterar_UI.connect(botoes_visivel)
	parede_roxo.alterar_UI.connect(botoes_visivel)
	pause_menu.pause_music.connect(on_pause_music)
	
	# mudar de sala
	parede_amarela.alterar_objeto.connect(mudar_sala)
	parede_vermelha.alterar_objeto.connect(mudar_sala)
	parede_ciano.alterar_objeto.connect(mudar_sala)
	parede_roxo.alterar_objeto.connect(mudar_sala)


########
# Monologue
########

func on_intro_monologue() -> void:
	# Visualizar
	pause_bgmusic()
	intro_monologue.set_process(true)
	intro_monologue.show()  # Ensure it's visible when starting

func end_of_dialogue() -> void:
	opening_eyes_animation()

func play_bgmusic() -> void:
	if pausado:
		BG_Jogo.seek(posicao)
		BG_Jogo.play_music()
		pausado = false

func pause_bgmusic() -> void:
	if BG_Jogo.playing:
		posicao = BG_Jogo.get_playback_position()
		BG_Jogo.stop()
		pausado = true

func on_pause_music(should_pause: bool) -> void:
	if should_pause:
		pause_bgmusic()
	else:
		play_bgmusic()

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

func cena_visivel(cena: String, show: bool) -> void:
	if cena_tipo_sala(cena):
		parede_visivel(cena, show)
	else:
		objeto_visivel(cena, show)

func parede_visivel(parede: String, show: bool) -> void:
	match parede:
		"amarela":
			if show:
				parede_amarela.show()
			else:
				parede_amarela.hide()
		"vermelha":
			if show:
				parede_vermelha.show()
			else:
				parede_vermelha.hide()
		"ciano":
			if show:
				parede_ciano.show()
			else:
				parede_ciano.hide()
		"roxo":
			if show:
				parede_roxo.show()
			else:
				parede_roxo.hide()
		"vazio":
			if show:
				parede_vazio.show()
			else:
				parede_vazio.hide()
		_:
			print("Error! Parede visivel")

func objeto_visivel(objeto: String, show: bool) -> void:
	parede_visivel(objetos_cena_link[objeto]["sala"], true)
	
	match objetos_cena_link[objeto]["sala"]:
		"amarela":
			if show:
				parede_amarela.carregar_objeto(objetos_cena_link[objeto]["id_cena"], objeto)
			else:
				parede_amarela.remover_objeto(objeto)
			
		"vermelha":
			if show:
				parede_vermelha.carregar_objeto(objetos_cena_link[objeto]["id_cena"], objeto)
			else:
				parede_vermelha.remover_objeto(objeto)
			
		"ciano":
			if show:
				parede_ciano.carregar_objeto(objetos_cena_link[objeto]["id_cena"], objeto)
			else:
				parede_ciano.remover_objeto(objeto)
			
		"roxo":
			if show:
				parede_roxo.carregar_objeto(objetos_cena_link[objeto]["id_cena"], objeto)
			else:
				parede_roxo.remover_objeto(objeto)
			
		"vazio":
			if show:
				parede_vazio.carregar_objeto(objetos_cena_link[objeto]["id_cena"], objeto)
			else:
				parede_vazio.remover_objeto(objeto)
			
		_:
			print("Error! Objeto Visivel")

func cena_tipo_sala(id: String) -> bool:
	if id in change_room_dictionary:
		return true
	else:
		return false

# Recebe a direção do movimento
func mudar_sala(objeto: String, direcao: String) -> void:	
	if direcao == "baixo":
		cena_visivel(Global.sala_que_estamos(), false)
		Global.retroceder_sala()
		cena_visivel(Global.sala_que_estamos(), true)
	elif direcao in ["direita", "esquerda", "cima"]:
		cena_visivel(change_room_dictionary[Global.sala_que_estamos()][direcao], true)
		cena_visivel(Global.sala_que_estamos(), false)
		Global.adicionar_sala_ao_historico(change_room_dictionary[Global.sala_que_estamos()][direcao])
	elif direcao == "clicar":
		cena_visivel(objeto, true)
		Global.adicionar_sala_ao_historico(objeto)
	
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
