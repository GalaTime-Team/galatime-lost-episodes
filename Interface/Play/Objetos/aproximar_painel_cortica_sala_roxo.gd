extends Control

@onready var pedako1 = $"Background/HBoxContainer/Vetor1/Caixa1/parte do puzzle 1"
@onready var pedako2 = $"Background/HBoxContainer/Vetor2/Caixa4/parte do puzzle 2"
@onready var pedako3 = $"Background/HBoxContainer/Vetor3/Caixa7/parte do puzzle 3"
@onready var pedako4 = $"Background/HBoxContainer/Vetor1/Caixa2/parte do puzzle 4"
@onready var pedako5 = $"Background/HBoxContainer/Vetor2/Caixa5/parte do puzzle 5"
@onready var pedako6 = $"Background/HBoxContainer/Vetor3/Caixa8/parte do puzzle 6"
@onready var pedako7 = $"Background/HBoxContainer/Vetor1/Caixa3/parte do puzzle 7"
@onready var pedako8 = $"Background/HBoxContainer/Vetor2/Caixa6/parte do puzzle 8"
@onready var pedako9 = $"Background/HBoxContainer/Vetor3/Caixa9/parte do puzzle 9"
@onready var concluido = $Concluido_som
@onready var item = $"Background/Item(exemplo)"

var angulo1 = 0
var angulo2 = 0
var angulo3 = 0
var angulo4 = 0
var angulo5 = 0
var angulo6 = 0
var angulo7 = 0
var angulo8 = 0
var angulo9 = 0
var posicao1 = 0
var posicao2 = 0
var posicao3 = 0
var posicao4 = 0
var posicao5 = 0
var posicao6 = 0
var posicao7 = 0
var posicao8 = 0
var posicao9 = 0
#porfavor nao fazer castração nuclear em uma pessoa cujo o nome é esse -> Artur Bazavlyak

func _ready() -> void:
	pass

func _on_parte_do_puzzle_1_pressed() -> void:
	angulo1 = (angulo1 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle1(angulo1)
	pedako1.texture_normal = nova_textura
	posicao1 += 1
	if posicao1 == 4:
		posicao1 = 0
	print(posicao1)

func _on_parte_do_puzzle_2_pressed() -> void:
	angulo2 = (angulo2 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle2(angulo2)
	pedako2.texture_normal = nova_textura
	posicao2 += 1
	if posicao2 == 4:
		posicao2 = 0
	print(posicao2)

func _on_parte_do_puzzle_3_pressed() -> void:
	angulo3 = (angulo3 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle3(angulo3)
	pedako3.texture_normal = nova_textura
	posicao3 += 1
	if posicao3 == 4:
		posicao3 = 0
	print(posicao3)

func _on_parte_do_puzzle_4_pressed() -> void:
	angulo4 = (angulo4 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle4(angulo4)
	pedako4.texture_normal = nova_textura
	posicao4 += 1
	if posicao4 == 4:
		posicao4 = 0
	print(posicao4)

func _on_parte_do_puzzle_5_pressed() -> void:
	angulo5 = (angulo5 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle5(angulo5)
	pedako5.texture_normal = nova_textura
	posicao5 += 1
	if posicao5 == 4:
		posicao5 = 0
	print(posicao5)

func _on_parte_do_puzzle_6_pressed() -> void:
	angulo6 = (angulo6 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle6(angulo6)
	pedako6.texture_normal = nova_textura
	posicao6 += 1
	if posicao6 == 4:
		posicao6 = 0
	print(posicao6)

func _on_parte_do_puzzle_7_pressed() -> void:
	angulo7 = (angulo7 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle7(angulo7)
	pedako7.texture_normal = nova_textura
	posicao7 += 1
	if posicao7 == 4:
		posicao7 = 0
	print(posicao7)

func _on_parte_do_puzzle_8_pressed() -> void:
	angulo8 = (angulo8 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle8(angulo8)
	pedako8.texture_normal = nova_textura
	posicao8 += 1
	if posicao8 == 4:
		posicao8 = 0
	print(posicao8)

func _on_parte_do_puzzle_9_pressed() -> void:
	angulo9 = (angulo9 + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle9(angulo9)
	pedako9.texture_normal = nova_textura
	posicao9 += 1
	if posicao9 == 4:
		posicao9 = 0
	print(posicao9)

func carregar_textura_do_angulo_puzzle1(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako1.png")
		90:
			return load("res://Asset/Images/pedako1_90.png")
		180:
			return load("res://Asset/Images/pedako1_180.png")
		270:
			return load("res://Asset/Images/pedako1_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle2(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako2.png")
		90:
			return load("res://Asset/Images/pedako2_90.png")
		180:
			return load("res://Asset/Images/pedako2_180.png")
		270:
			return load("res://Asset/Images/pedako2_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle3(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako3.png")
		90:
			return load("res://Asset/Images/pedako3_90.png")
		180:
			return load("res://Asset/Images/pedako3_180.png")
		270:
			return load("res://Asset/Images/pedako3_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle4(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako4.png")
		90:
			return load("res://Asset/Images/pedako4_90.png")
		180:
			return load("res://Asset/Images/pedako4_180.png")
		270:
			return load("res://Asset/Images/pedako4_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle5(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako5.png")
		90:
			return load("res://Asset/Images/pedako5_90.png")
		180:
			return load("res://Asset/Images/pedako5_180.png")
		270:
			return load("res://Asset/Images/pedako5_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle6(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako6.png")
		90:
			return load("res://Asset/Images/pedako6_90.png")
		180:
			return load("res://Asset/Images/pedako6_180.png")
		270:
			return load("res://Asset/Images/pedako6_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle7(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako7.png")
		90:
			return load("res://Asset/Images/pedako7_90.png")
		180:
			return load("res://Asset/Images/pedako7_180.png")
		270:
			return load("res://Asset/Images/pedako7_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle8(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako8.png")
		90:
			return load("res://Asset/Images/pedako8_90.png")
		180:
			return load("res://Asset/Images/pedako8_180.png")
		270:
			return load("res://Asset/Images/pedako8_270.png")
		_:
			return null

func carregar_textura_do_angulo_puzzle9(graus: int) -> Texture2D:
	match graus:
		0:
			return load("res://Asset/Images/pedako9.png")
		90:
			return load("res://Asset/Images/pedako9_90.png")
		180:
			return load("res://Asset/Images/pedako9_180.png")
		270:
			return load("res://Asset/Images/pedako9_270.png")
		_:
			return null

func _on_button_pressed() -> void:
	if posicao1 == 2 && posicao2 == 3 && posicao3 == 1 && posicao4 == 3 && posicao5 == 2 && posicao6 == 2 && posicao7 == 3 && posicao8 == 2 && posicao9 == 3:
		concluido.play()
		item.show()
