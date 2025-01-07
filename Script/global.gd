extends Node

#####
# Salas
#####

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

#########
# Puzzles
#########
var puzzle1_complete: bool = false #Foi Completo?
const puzzle1_valores : Array = [
	4 , 
	5 , 
	1
	]
var puzzle2_complete: bool = false #Foi Completo?
const puzzle2_valores : Array = [
	6 , 
	1 , 
	0
	]

#########
# item
#########
var item_coletado: bool = false

func new_game():
	monologuecont = false
	puzzle1_complete = false
	puzzle2_complete = false
	sala_que_estamos = "amarela"
