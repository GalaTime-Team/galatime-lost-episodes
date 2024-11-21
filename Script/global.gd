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
#####
# Salvar as Configurações
#####

func save_settings():
	var config = ConfigFile.new()
	config.set_value("settings", "master_volume", master_volume)
	config.set_value("settings", "music_volume", music_volume)
	config.set_value("settings", "fullscreen", fullscreen)
	config.save("user://settings.cfg")

#####
# Carregar as Configurações
#####

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		master_volume = config.get_value("settings", "master_volume", 0.5)
		music_volume = config.get_value("settings", "music_volume", 0.5)
		fullscreen = config.get_value("settings", "fullscreen", false)

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
