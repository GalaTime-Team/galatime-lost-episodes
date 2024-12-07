extends Node

func save_game():
	var file = FileAccess.open("user://savegame.txt", FileAccess.WRITE)
	file.store_string(Global.sala_que_estamos)
	file.close()

func load_game():
	var file = FileAccess.open("user://savegame.txt", FileAccess.READ)
	Global.sala_que_estamos = file.get_as_text()
	file.close()

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
