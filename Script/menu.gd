class_name Menu
extends Control

@onready var settings = $Settings as Settings
@onready var menuclick_sound = $s_menu_click
@onready var margin_container = $MarginContainer as MarginContainer

func _ready() -> void:
	handle_connecting_signal()
	# Configuração dos botões no grupo button
	for button in get_tree().get_nodes_in_group("button"):
		if button is Button:
			button.pressed.connect(on_button_pressed.bind(button))

func on_back_setting_menu() -> void:
	margin_container.visible = true
	settings.visible = false

func on_settings_pressed() -> void:
	margin_container.visible = false
	settings.set_process(true)
	settings.visible = true

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu)
# Função para mudar de cena
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play":
			var _game: bool = get_tree().change_scene_to_file("res://Interface/play1.tscn")
		"Settings":
			on_settings_pressed()
		"Credits":
			var _credits: bool = get_tree().change_scene_to_file("res://Interface/tela_creditos.tscn")
		"Leave":
			get_tree().quit()
