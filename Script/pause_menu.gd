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

#####
# AUX
#####

func initial_values():
	panel_container.visible = false
	panel_container.modulate.a = 0.0


func testEsc():
	if Input.is_action_just_pressed("escape") and panel_container.visible == false:
		open_pause_menu()
	elif Input.is_action_just_pressed("escape") and panel_container.visible == true:
		resume_game()

#####
# Ready // Process
#####

func _ready() -> void:
	initial_values()
	
	blur_animation.play("RESET")
	
	handle_connecting_signal()

func _process(_delta: float):
	testEsc()

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

func options():
	settings.set_process(true)
	settings.backgroundvisible()
	settings.visible = true

########
#conecção do settings
########

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	settings.backgroundvisible()
	settings.visible = false

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu) #Conectar com a func do settings e poder guardar as informações

#####
# Buttons Interactions
#####

func _on_texture_button_pressed() -> void:
	menu_click.play()
	if panel_container.visible == false:
		open_pause_menu()
	elif panel_container.visible == true:
		resume_game()

func _on_resume_pressed() -> void:
	menu_click.play()
	resume_game()

func _on_options_pressed() -> void:
	menu_click.play()
	options()

func _on_leave_pressed() -> void:
	menu_click.play()
	get_tree().quit()

# Hover Sounds

func _on_resume_mouse_entered() -> void:
	menu_hover.play()

func _on_options_mouse_entered() -> void:
	menu_hover.play()

func _on_leave_mouse_entered() -> void:
	menu_hover.play()
