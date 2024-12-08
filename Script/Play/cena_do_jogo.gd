class_name CenaDoJogo
extends Control

const change_room_dictionary : Dictionary = {
	"amarela" : ["vermelha" , "ciano"],
	"vermelha" : ["roxo" , "amarela"],
	"ciano" : ["amarela" , "roxo"],
	"roxo" : ["ciano" , "vermelha"]
}

func _ready() -> void:
	pass
