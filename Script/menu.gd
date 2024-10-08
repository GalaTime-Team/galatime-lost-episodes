class_name Menu
extends Control

@onready var settings: Control = $Settings
@onready var menuclick_sound = $s_menu_click


func _ready() -> void:
	# Configuração dos botões no grupo button
	for button in get_tree().get_nodes_in_group("button"):
		if button is Button:
			button.pressed.connect(on_button_pressed.bind(button))

# Função para mudar de cena
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play":
			var _game: bool = get_tree().change_scene_to_file("res://Interface/play1.tscn")
		"Settings":
			var _controls: bool = get_tree().change_scene_to_file("res://Interface/settings.tscn")
		"Credits":
			var _credits: bool = get_tree().change_scene_to_file("res://Interface/tela_creditos.tscn")
		"Leave":
			get_tree().quit()
