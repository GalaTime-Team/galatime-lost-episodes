extends Control

@onready var pedakos = [
	$"Background/HBoxContainer/Vetor1/Caixa1/parte do puzzle 1",
	$"Background/HBoxContainer/Vetor2/Caixa4/parte do puzzle 2",
	$"Background/HBoxContainer/Vetor3/Caixa7/parte do puzzle 3",
	$"Background/HBoxContainer/Vetor1/Caixa2/parte do puzzle 4",
	$"Background/HBoxContainer/Vetor2/Caixa5/parte do puzzle 5",
	$"Background/HBoxContainer/Vetor3/Caixa8/parte do puzzle 6",
	$"Background/HBoxContainer/Vetor1/Caixa3/parte do puzzle 7",
	$"Background/HBoxContainer/Vetor2/Caixa6/parte do puzzle 8",
	$"Background/HBoxContainer/Vetor3/Caixa9/parte do puzzle 9"
]


@onready var concluido = $Concluido_som
@onready var item = $"Background/Item(exemplo)"
@onready var colocar = $Background/Colocar

var angulos = []

var posicao = []

func _ready() -> void:
	for i in range(9):
		angulos.append(0)
		posicao.append(0)
	if "item_1" in Global.inventario:
		colocar.show()
	if Global.puzzles["puzzle2"].completo:
		pedakos[1].visible = true
	

	# Se o puzzle foi concluído anteriormente, carrega os ângulos salvos
	if Global.puzzles["puzzle2"].completo:
		para_de_girar()
		var solu = Global.puzzles["puzzle2"].solucao

		# Para cada pedaço, define o ângulo e atualiza a textura
		angulos[0] = solu[0]
		pedakos[0].texture_normal = carregar_textura_do_angulo_puzzle1(solu[0])
		

		angulos[1] = solu[1]
		pedakos[1].texture_normal = carregar_textura_do_angulo_puzzle2(solu[1])

		angulos[2] = solu[2]
		pedakos[2].texture_normal = carregar_textura_do_angulo_puzzle3(solu[2])

		angulos[3] = solu[3]
		pedakos[3].texture_normal = carregar_textura_do_angulo_puzzle4(solu[3])

		angulos[4] = solu[4]
		pedakos[4].texture_normal = carregar_textura_do_angulo_puzzle5(solu[4])

		angulos[5] = solu[5]
		pedakos[5].texture_normal = carregar_textura_do_angulo_puzzle6(solu[5])

		angulos[6] = solu[6]
		pedakos[6].texture_normal = carregar_textura_do_angulo_puzzle7(solu[6])

		angulos[7] = solu[7]
		pedakos[7].texture_normal = carregar_textura_do_angulo_puzzle8(solu[7])

		angulos[8] = solu[8]
		pedakos[8].texture_normal = carregar_textura_do_angulo_puzzle9(solu[8])

func _on_parte_do_puzzle_1_pressed() -> void:
	angulos[0] = (angulos[0] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle1(angulos[0])
	pedakos[0].texture_normal = nova_textura
	posicao[0] += 1
	if posicao[0] == 4:
		posicao[0] = 0
	print(posicao[0])

func _on_parte_do_puzzle_2_pressed() -> void:
	angulos[1] = (angulos[1] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle2(angulos[1])
	pedakos[1].texture_normal = nova_textura
	posicao[1] += 1
	if posicao[1] == 4:
		posicao[1] = 0
	print(posicao[1])

func _on_parte_do_puzzle_3_pressed() -> void:
	angulos[2] = (angulos[2] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle3(angulos[2])
	pedakos[2].texture_normal = nova_textura
	posicao[2] += 1
	if posicao[2] == 4:
		posicao[2] = 0
	print(posicao[2])

func _on_parte_do_puzzle_4_pressed() -> void:
	angulos[3] = (angulos[3] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle4(angulos[3])
	pedakos[3].texture_normal = nova_textura
	posicao[3] += 1
	if posicao[3] == 4:
		posicao[3] = 0
	print(posicao[3])

func _on_parte_do_puzzle_5_pressed() -> void:
	angulos[4] = (angulos[4] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle5(angulos[4])
	pedakos[4].texture_normal = nova_textura
	posicao[4] += 1
	if posicao[4] == 4:
		posicao[4] = 0
	print(posicao[4])

func _on_parte_do_puzzle_6_pressed() -> void:
	angulos[5] = (angulos[5] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle6(angulos[5])
	pedakos[5].texture_normal = nova_textura
	posicao[5] += 1
	if posicao[5] == 4:
		posicao[5] = 0
	print(posicao[5])

func _on_parte_do_puzzle_7_pressed() -> void:
	angulos[6] = (angulos[6] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle7(angulos[6])
	pedakos[6].texture_normal = nova_textura
	posicao[6] += 1
	if posicao[6] == 4:
		posicao[6] = 0
	print(posicao[6])

func _on_parte_do_puzzle_8_pressed() -> void:
	angulos[7] = (angulos[7] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle8(angulos[7])
	pedakos[7].texture_normal = nova_textura
	posicao[7] += 1
	if posicao[7] == 4:
		posicao[7] = 0
	print(posicao[7])

func _on_parte_do_puzzle_9_pressed() -> void:
	angulos[8] = (angulos[8] + 90) % 360
	var nova_textura = carregar_textura_do_angulo_puzzle9(angulos[8])
	pedakos[8].texture_normal = nova_textura
	posicao[8] += 1
	if posicao[8] == 4:
		posicao[8] = 0
	print(posicao[8])

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
	var solucao = [180, 270, 90, 270, 180, 180, 270, 180, 270]
	var resolvido = true
	for i in range(9):
		if angulos[i] != solucao[i]:
			resolvido = false
			break
	if resolvido:
		concluido.play()
		item.show()
		Global.puzzles["puzzle2"].completo = true
		Global.puzzles["puzzle2"].solucao = angulos.duplicate()
		Global.remover_item("item_1","item parede amarela","Peça da parede de cortiça","res://Asset/Images/pedako1.png")
		SaveGame.save_game()
		para_de_girar()

func para_de_girar() -> void:
	for pedako in pedakos:
		pedako.disabled = true

func _on_colocar_pressed() -> void:
	pedakos[0].visible = true
	colocar.hide()
	
