extends Node

func save_game():
	var puzzles_completos = {}
	
	for puzzle_nome in Global.puzzles.keys():
		puzzles_completos[puzzle_nome] = { "completo": Global.puzzles[puzzle_nome]["completo"] }
	
	var game = {
		"monologuecont": Global.monologuecont,
		"puzzles_completos": puzzles_completos,
		"historico_de_salas": Global.historico_de_salas,
		"inventario": Global.inventario,
	}
	
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(game))
		file.close()
	else:
		print("Erro ao salvar configurações.")


func load_game():
	var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	if file:
		var content_game = file.get_as_text()
		file.close()
		var game = JSON.parse_string(content_game)
		if game:
			Global.monologuecont = game.get("monologuecont", Global.monologuecont)
			Global.historico_de_salas = game.get("historico_de_salas", Global.historico_de_salas)
			
			var puzzles_completos = game.get("puzzles_completos", {})
			sort_puzzles_completos(puzzles_completos)
			
			Global.inventario = game.get("inventario", Global.inventario)
		else:
			print("Erro ao parsear configurações")
	else:
		print("Arquivo de configurações não encontrado ou erro ao abrir.")


func save_settings():
	# Criar um dicionário com os dados a serem salvos
	var settings = {
		"master_volume": Global.master_volume,
		"music_volume": Global.music_volume,
		"sfx_volume": Global.sfx_volume,
		"fullscreen": Global.fullscreen,
		"res_screen": Global.res_screen,
		"language": Global.language
	}

	# Abrir o arquivo para escrita e salvar os dados como JSON
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(settings))
		file.close()
	else:
		print("Erro ao salvar configurações.")


func load_settings():
	# Abrir o arquivo para leitura
	var file = FileAccess.open("user://settings.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()

		# Parsear o JSON e carregar os valores
		var settings = JSON.parse_string(content)
		if settings:
			Global.master_volume = settings.get("master_volume", Global.master_volume)
			Global.music_volume = settings.get("music_volume", Global.music_volume)
			Global.sfx_volume = settings.get("sfx_volume", Global.sfx_volume)
			Global.fullscreen = settings.get("fullscreen", Global.fullscreen)
			Global.res_screen = settings.get("res_screen", Global.res_screen)
			Global.language = settings.get("language", Global.language)
		else:
			print("Erro ao parsear configurações")
	else:
		Global.master_volume = 50
		Global.music_volume = 50
		Global.sfx_volume = 50
		Global.language = 0
		print("Arquivo de configurações não encontrado ou erro ao abrir.")

func sort_puzzles_completos(puzzles_completos):
	for puzzle_nome in puzzles_completos.keys():
		if Global.puzzles.has(puzzle_nome):
			Global.puzzles[puzzle_nome]["completo"] = puzzles_completos[puzzle_nome]
