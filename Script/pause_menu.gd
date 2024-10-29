extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $PanelContainer
@onready var pause_menu_container: VBoxContainer = $PanelContainer/Pause_Menu_Container
@onready var back: Button = $PanelContainer/Back
@onready var settings: Settings = $Settings

# Importar Sons
@onready var s_menu_click: AudioStreamPlayer = $s_menu_click
@onready var s_menu_hover: AudioStreamPlayer = $s_menu_hover

#####
# AUX
#####

func initial_values():
	panel_container.visible = false
	panel_container.modulate.a = 0.0
	
	back.modulate.a = 0.0
	
	pause_menu_container.visible = true
	pause_menu_container.modulate.a = 1.0

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
	
	animation_player.play("RESET")
	
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
	animation_player.play("blur")
	tween.tween_property(panel_container, "modulate:a", 1.0 ,0.2)
	await tween.finished

func resume_game():
	# Garantir Valores
	panel_container.visible = true
	panel_container.modulate.a = 1.0
	
	# Animação
	var tween = self.create_tween()
	animation_player.play_backwards("blur")
	tween.tween_property(panel_container, "modulate:a", 0.0 ,0.2)
	await tween.finished
	
	panel_container.visible = false

func options():
	settings.set_process(true)
	settings.visible = true

#####
# Buttons Interactions
#####

#conecção do settings

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	settings.visible = false

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu) #Conectar com a func do settings e poder guardar as informações
# Pressed

func _on_texture_button_pressed() -> void:
	s_menu_click.play()
	if panel_container.visible == false:
		open_pause_menu()
	elif panel_container.visible == true:
		resume_game()

func _on_resume_pressed() -> void:
	s_menu_click.play()
	resume_game()

func _on_options_pressed() -> void:
	s_menu_click.play()
	options()

func _on_leave_pressed() -> void:
	s_menu_click.play()
	get_tree().quit()

func _on_back_pressed() -> void:
	s_menu_click.play()
	
	var tween = self.create_tween()
	tween.tween_property(back, "modulate:a", 0.0 ,0.2)
	
	pause_menu_container.visible = true
	back.visible = false
	
	tween.tween_property(pause_menu_container, "modulate:a", 1.0 ,0.2)
	await tween.finished
	tween.stop()

# Hover Sounds

func _on_resume_mouse_entered() -> void:
	s_menu_hover.play()

func _on_options_mouse_entered() -> void:
	s_menu_hover.play()

func _on_leave_mouse_entered() -> void:
	s_menu_hover.play()

func _on_back_mouse_entered() -> void:
	s_menu_hover.play()
