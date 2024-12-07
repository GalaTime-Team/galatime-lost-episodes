extends Node

#####
# salas
#####

var parede_amarela = load("res://Interface/Play/parede_amarela.tscn")
var parede_vermelha = load("res://Interface/Play/parede_vermelha.tscn")
var parede_ciano = load("res://Interface/Play/parede_ciano.tscn")
var parede_roxo = load("res://Interface/Play/parede_roxo.tscn")
var vazio = load("res://Interface/Play/parede_vazio.tscn")

const change_room_dictionary : Dictionary = {
	"amarela" : ["vermelha" , "ciano"],
	"vermelha" : ["roxo" , "amarela"],
	"ciano" : ["amarela" , "roxo"],
	"roxo" : ["ciano" , "vermelha"]
}

var sala_que_estamos : String

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
var back_scene: bool = false #Está a transitar?

#########
# Puzzles
#########
var puzzle1_complete: bool = false #Foi Compleot?
const puzzle1_valores : Array = [
	4 , 
	5 , 
	1
	]
var puzzle2_complete: bool = false #Foi Compleot?
const puzzle2_valores : Array = [
	6 , 
	1 , 
	0
	]

func new_game():
	monologuecont = false
	puzzle1_complete = false
	puzzle2_complete = false
	sala_que_estamos = "amarela"

func cena_direcao(direcao : String) -> void:
	var proxima_sala : String
	if direcao == "esquerda":
		proxima_sala = change_room_dictionary[sala_que_estamos][0]
	elif direcao == "direita":
		proxima_sala = change_room_dictionary[sala_que_estamos][1]
	else:
		proxima_sala = "vazio"
	mudar_sala(proxima_sala)

func mudar_sala(sala : String) -> void:
	match sala:
		"amarela":
			get_tree().change_scene_to_packed(parede_amarela)
		"vermelha":
			get_tree().change_scene_to_packed(parede_vermelha)
		"ciano":
			get_tree().change_scene_to_packed(parede_ciano)
		"roxo":
			get_tree().change_scene_to_packed(parede_roxo)
		"vazio":
			get_tree().change_scene_to_packed(vazio)
