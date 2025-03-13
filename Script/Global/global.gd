extends Node

#####
# Salas
#####

var historico_de_salas : Array = []
var MAX_HISTORICO: int = 4

#####
# Options
#####

var master_volume: float
var music_volume: float
var sfx_volume: float
var fullscreen: int = 0 # windowed
var res_screen: int = 0 # 1080p
var language: int = 0 # English

#####
# AUX
#####
var monologuecont: bool = false #Já apresentou o monologo?
var continuarConfirmar: bool = false
#########
# Puzzles
#########

var puzzles: Dictionary = {
	"puzzle1" : {
		"completo": false,
		"solucao": ["2","1","2"]
		}
}

#########
#link dos cenarios
#########

var objetos_cena_link: Dictionary = {
	"Aproximar_PostIt" : "Aproximar_PostIt_Sala_amarela",
	"Aproximar_trash" : "Aproximar_trash_Sala_amarela",
	"Aproximar_banca" : "Aproximar_Banca_Sala_amarela",
	"Aproximar_cookie" : "Aproximar_Cookie_Sala_amarela",
	"Puzzle1" : "puzzle1-Sala_amarela"
}

#########
# inventario e itens
#########
var inventario : Dictionary 

func item_guardados(chave,nome,descricao,imagem):
	inventario[chave] = {"nome" : nome , "descricao" : descricao , "imagem" : imagem}

func new_game():
	monologuecont = false
	for key in puzzles:
		puzzles[key].completo = false
	adicionar_sala_ao_historico("amarela")

func adicionar_sala_ao_historico(nova_sala):
	historico_de_salas.push_back(nova_sala)
	
	# Mantém o tamanho máximo da pilha
	if historico_de_salas.size() > MAX_HISTORICO:
		historico_de_salas.pop_front() # Remove o elemento mais antigo

func sala_que_estamos() -> String:
	for sala in historico_de_salas:
		if sala not in ["amarela", "vermelha", "ciano", "roxo"]:
			return historico_de_salas[historico_de_salas.size() - 1]
	return "Nenhuma sala correspondente encontrada"

func sala_antecedente() -> String:
	return historico_de_salas[historico_de_salas.size() - 2]

func retroceder_sala():
	if historico_de_salas.size() > 0:
		historico_de_salas.pop_back() # Remove o elemento mais recente
