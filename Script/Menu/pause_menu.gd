class_name PauseMenu
extends Control

@export var blur_animation: AnimationPlayer

@export_category("Páginas")
@export var settings: Settings
@export var panel_container: PanelContainer

# Importar Sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

signal out_pause_menu

#####
# AUX
#####

func initial_values():
	panel_container.visible = false
	panel_container.modulate.a = 0.0

#####
# Ready // Process
#####

func _ready() -> void:
	initial_values()
	
	blur_animation.play("RESET")
	
	handle_connecting_signal()
	set_process(false)

#####
# Main Options
#####
func open_pause_menu():
	# Correr os valores iniciais de visão e visibilidade
	initial_values()
	panel_container.visible = true
	
	# Animação
	var tween = self.create_tween()
	blur_animation.play("blur")
	tween.tween_property(panel_container, "modulate:a", 1.0 ,0.2)
	await tween.finished

func resume_game():
	# Garantir Valores
	panel_container.visible = true
	panel_container.modulate.a = 1.0
	
	# Animação
	var tween = self.create_tween()
	blur_animation.play_backwards("blur")
	tween.tween_property(panel_container, "modulate:a", 0.0 ,0.2)
	await tween.finished
	
	panel_container.visible = false
	out_pause_menu.emit()

func options():
	settings.set_process(true)
	settings.backgroundvisible()
	settings.modulate.a = 0.0
	settings.show()
	
	var tween = self.create_tween()
	tween.tween_property(settings, "modulate:a", 1.0, 0.2)
	await tween.finished

########
#conecção do settings
########

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	settings.modulate.a = 1.0
	
	var tween = self.create_tween()
	tween.tween_property(settings, "modulate:a", 0.0, 0.2)
	await tween.finished
	settings.backgroundvisible()
	settings.hide()

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu) #Conectar com a func do settings e poder guardar as informações

########
# Buttons Interactions
########

# Pressed

func _on_resume_pressed() -> void:
	menu_click.play()
	resume_game()
	set_process(false)

func _on_options_pressed() -> void:
	menu_click.play()
	options()

func _on_leave_pressed() -> void:
	menu_click.play()
	get_tree().quit()

func _on_texture_button_pressed() -> void:
	resume_game()
	set_process(false)

# Hover Sounds

func _on_resume_mouse_entered() -> void:
	menu_hover.play()

func _on_options_mouse_entered() -> void:
	menu_hover.play()

func _on_leave_mouse_entered() -> void:
	menu_hover.play()
