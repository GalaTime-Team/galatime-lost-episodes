extends Node

var master_volume: float = 1.0  # Volume mestre padrão
var music_volume: float = 1.0  # Volume da música padrão
var fullscreen: bool = false  # Fullscreen desativado por padrão

# Função para salvar configurações
func save_settings():
	var config = ConfigFile.new()
	config.set_value("settings", "master_volume", master_volume)
	config.set_value("settings", "music_volume", music_volume)
	config.set_value("settings", "fullscreen", fullscreen)
	config.save("user://settings.cfg")

# Função para carregar configurações
func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		master_volume = config.get_value("settings", "master_volume", 1.0)
		music_volume = config.get_value("settings", "music_volume", 1.0)
		fullscreen = config.get_value("settings", "fullscreen", false)
