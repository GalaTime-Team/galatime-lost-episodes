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
	#Disabilitar os butões para não acessar durante o fade
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Settings.disabled = true
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Credits.disabled = true
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Leave.disabled = true
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Play.disabled = true
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Play.mouse_entered.disconnect(_on_play_mouse_entered)
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Settings.mouse_entered.disconnect(_on_settings_mouse_entered)
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Credits.mouse_entered.disconnect(_on_credits_mouse_entered)
	$MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Leave.mouse_entered.disconnect(_on_leave_mouse_entered)
	
	var tween = self.create_tween()
	# Hide Settings button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Settings, "modulate:a", 0.0 ,0.5)
	await tween.tween_interval(1.0)

	# Hide Credits button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Credits,  "modulate:a", 0.0 ,0.5)
	await tween.tween_interval(1.0)

	# Hide Leave button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Leave,  "modulate:a", 0.0 ,0.5)
	await tween.tween_interval(1.0)

	# Hide Play button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Play,  "modulate:a", 0.0 ,0.5)
	await tween.tween_interval(1.0)

	await tween.finished
	var _game: bool = get_tree().change_scene_to_file("res://Interface/Sala_Amarela.tscn")

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
