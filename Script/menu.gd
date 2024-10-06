extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Configuração dos botões
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button))

# Função chamada quando um botão é pressionado
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play":
			var _game: bool = get_tree().change_scene() #change_scene_to_file
		"Settings":
			var _controls: bool = get_tree().change_scene_to_file("res://Interface/settings.tscn")
		"Credits":
			var _credits: bool = get_tree().change_scene_to_file("res://Interface/tela_creditos.tscn")
		"Leave":
			get_tree().quit()
