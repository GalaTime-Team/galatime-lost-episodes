class_name Menu
extends Control

@export_category("Páginas")
@export var settings: Settings
@export var margin_container: MarginContainer
@export var tela_creditos: TelaCreditos

# Importar Sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

func _ready() -> void:
	handle_connecting_signal()
	margin_container.modulate.a = 0.0
	
	var tween = self.create_tween()
	
	tween.tween_property(margin_container, "modulate:a", 1.0 ,1.0)
	await tween.finished
	tween.stop()

#####
# Transição
#####

func fade(fades_out, fades_in) -> void:
	fades_out.modulate.a = 1.0
	fades_in.modulate.a = 0.0
	
	var tween = self.create_tween()
	
	tween.tween_property(fades_out, "modulate:a", 0.0 ,0.2)
	
	fades_in.visible = true
	
	tween.tween_property(fades_in, "modulate:a", 1.0 ,0.2)
	await tween.finished
	tween.stop()
	
	fades_out.visible = false

#####
# Back Pressed
#####

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	fade(settings,margin_container)
	
func on_back_credits_menu()-> void:
	fade(tela_creditos,margin_container)

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
	tween.tween_interval(1.0)

	# Hide Credits button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Credits,  "modulate:a", 0.0 ,0.5)
	tween.tween_interval(1.0)

	# Hide Leave button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Leave,  "modulate:a", 0.0 ,0.5)
	tween.tween_interval(1.0)

	# Hide Play button
	tween.tween_property($MarginContainer/MenuContainer/HBoxContainer/VBoxContainer/Play,  "modulate:a", 0.0 ,0.5)
	tween.tween_interval(1.0)

	await tween.finished
	tween.stop()
	var _game: bool = get_tree().change_scene_to_file("res://Interface/Sala_Amarela.tscn")

func _on_settings_pressed() -> void:
	# Som
	menu_click.play()
	# Visualizar
	settings.set_process(true)
	fade(margin_container,settings)

func _on_credits_pressed() -> void:
	# Som
	menu_click.play()
	# Visualizar
	tela_creditos.set_process(true)
	fade(margin_container,tela_creditos)

func _on_leave_pressed() -> void:
	get_tree().quit()

#####
# Hover Handeling
#####

func _on_play_mouse_entered() -> void:
	menu_hover.play()

func _on_settings_mouse_entered() -> void:
	menu_hover.play()

func _on_credits_mouse_entered() -> void:
	menu_hover.play()

func _on_leave_mouse_entered() -> void:
	menu_hover.play()
