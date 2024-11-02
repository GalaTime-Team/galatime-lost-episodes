extends Node

var master_volume: float = 0.5  # Volume mestre padrão
var music_volume: float = 0.5  # Volume da música padrão
var fullscreen: bool = false  # Fullscreen desativado por padrão
var monologuecont: bool = false # Monologue cont
var back_scene: bool = false #back to scene

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
		master_volume = config.get_value("settings", "master_volume", 0.5)
		music_volume = config.get_value("settings", "music_volume", 0.5)
		fullscreen = config.get_value("settings", "fullscreen", false)
