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
		"solucao": ["4","5","1"]
		},
	"puzzle2" : {
		"completo": false, 
		"solucao": ["6","1","0"]
		}
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
	return historico_de_salas[historico_de_salas.size() - 1]

func sala_antecedente() -> String:
	return historico_de_salas[historico_de_salas.size() - 2]

func retroceder_sala():
	if historico_de_salas.size() > 0:
		historico_de_salas.pop_back() # Remove o elemento mais recente
