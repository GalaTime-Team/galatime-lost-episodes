extends Node

#####
# Options
#####

var master_volume: float
var music_volume: float
var sfx_volume: float
var fullscreen: bool
var res_screen: String
var language: String

#####
# AUX
#####
var monologuecont: bool = false
var back_scene: bool = false



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
