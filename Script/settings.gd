extends Control

@onready var volume_slider = $Screen/VBoxContainer/MasterVolume  # Referência ao slider de volume mestre
@onready var music_volume_slider = $Screen/VBoxContainer/MusicVolume  # Referência ao slider de volume de música
@onready var fullscreen_checkbox = $Screen/HBoxContainer/VBoxContainer2/FullScreen  # Referência à checkbox de fullscreen

# Função chamada quando a cena entra pela primeira vez
func _ready() -> void:
	# Conecta os botões do grupo "button" à função on_button_pressed
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button))
	
	# Carregar configurações globais ao abrir a cena
	volume_slider.value = Global.master_volume
	music_volume_slider.value = Global.music_volume
	fullscreen_checkbox.button_pressed = Global.fullscreen
	
	# Aplicar as configurações ao iniciar
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(Global.master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(Global.music_volume))
	if Global.fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Função chamada quando um botão é pressionado
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Back":
			get_tree().change_scene_to_file("res://Interface/menu.tscn")

# Quando o estado da checkbox de fullscreen mudar
func _on_full_screen_toggled(button_pressed: bool) -> void:
	Global.fullscreen = button_pressed
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Quando o valor do slider de volume mestre mudar
func _on_master_volume_value_changed(value: float) -> void:
	Global.master_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))

# Quando o valor do slider de volume da música mudar
func _on_music_volume_value_changed(value: float) -> void:
	Global.music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))

# Função auxiliar para converter valores lineares de volume em decibéis
func linear2db(value: float) -> float:
	if value == 0:
		return -80  # Volume mínimo
	return 20 * log(value)

# Função para salvar as configurações quando sair da cena
func _on_SaveButton_pressed() -> void:
	Global.save_settings()
