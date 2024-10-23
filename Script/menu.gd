class_name Menu
extends Control

@onready var settings: Settings = $Settings
@onready var margin_container: MarginContainer = $MarginContainer
@onready var tela_creditos: TelaCreditos = $TelaCreditos

# Importar Sons
@onready var s_menu_click: AudioStreamPlayer = $s_menu_click
@onready var s_menu_hover: AudioStreamPlayer = $s_menu_hover

func _ready() -> void:
	handle_connecting_signal() #ao inciar o programa o programa ira ter o sinal com os settings

#####
# Back Pressed
#####

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	margin_container.visible = true
	settings.visible = false
	
func on_back_credits_menu()-> void:
	margin_container.visible = true
	tela_creditos.visible = false

#####
# Back Signals
#####

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu) #Conectar com a func do settings e poder guardar as informações
	tela_creditos.back_credits_menu.connect(on_back_credits_menu)

#####
# Pressed Handeling
#####

func _on_play_pressed() -> void:
	var _game: bool = get_tree().change_scene_to_file("res://Interface/play1.tscn")


func _on_settings_pressed() -> void:
	# Som
	s_menu_click.play()
	# Visualizar
	margin_container.visible = false
	settings.set_process(true)
	settings.visible = true


func _on_credits_pressed() -> void:
	# Som
	s_menu_click.play()
	# Visualizar
	margin_container.visible = false
	tela_creditos.set_process(true)
	tela_creditos.visible = true


func _on_leave_pressed() -> void:
	get_tree().quit()

#####
# Hover Handeling
#####

func _on_play_mouse_entered() -> void:
	s_menu_hover.play()

func _on_settings_mouse_entered() -> void:
	s_menu_hover.play()

func _on_credits_mouse_entered() -> void:
	s_menu_hover.play()

func _on_leave_mouse_entered() -> void:
	s_menu_hover.play()
