class_name Menu
extends Control

@onready var settings = $Settings as Settings
@onready var menuclick_sound = $s_menu_click as AudioStreamPlayer
@onready var margin_container = $MarginContainer as MarginContainer

func _ready() -> void:
	handle_connecting_signal() #ao inciar o programa o programa ira ter o sinal com os settings
	# Configuração dos botões no grupo button
	for button in get_tree().get_nodes_in_group("button"):
		if button is Button:
			button.pressed.connect(on_button_pressed.bind(button))

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	margin_container.visible = true
	settings.visible = false

func on_settings_pressed() -> void: #a margem fica invisivel e os settings.set_process(true) fica a True para poder entrar nos settings
	margin_container.visible = false
	settings.set_process(true)
	settings.visible = true

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu) #Conectar com a func do settings e poder guardar as informações
# Função para mudar de cena
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play":
			var _game: bool = get_tree().change_scene_to_file("res://Interface/play1.tscn")
		"Settings":
			on_settings_pressed() #mostrar os settings atraves do settings.set_process(true)
		"Credits":
			var _credits: bool = get_tree().change_scene_to_file("res://Interface/tela_creditos.tscn") #Subestituir por uma func		"Leave":
			get_tree().quit()
