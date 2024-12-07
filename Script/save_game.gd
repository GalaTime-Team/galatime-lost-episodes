extends Node

func save_game():
	
	var game = {
		"monologuecont": Global.monologuecont,
		"puzzle1_complete": Global.puzzle1_complete,
		"puzzle2_complete": Global.puzzle2_complete,
		"sala_que_estamos": Global.sala_que_estamos
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
			Global.puzzle1_complete = game.get("puzzle1_complete", Global.puzzle1_complete)
			Global.puzzle2_complete = game.get("puzzle2_complete", Global.puzzle2_complete)
			Global.sala_que_estamos = game.get("sala_que_estamos", Global.sala_que_estamos)
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
		print("Arquivo de configurações não encontrado ou erro ao abrir.")
