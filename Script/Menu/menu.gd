class_name Menu
extends Control

@export var menu: Menu
@export var shield: PanelContainer # Utilizado para não haver spam de input, pois causa bug visual nas transições

@export_category("Butões")
@export var play_button: Button
@export var continue_button: Button
@export var settings_button: Button
@export var credits_button: Button
@export var leave_button: Button

@export_category("Páginas")
@export var settings: Settings
@export var margin_container: MarginContainer
@export var tela_creditos: TelaCreditos
@export var blur_animation: AnimationPlayer
@export var warning_popup: Warning_Popup
@export var blur: ColorRect

# Importar Sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

var start_game = load("res://Interface/Play/cena_do_jogo.tscn")


func _ready() -> void:
	if FileAccess.file_exists("user://savegame.json"):
		continue_button.show()
	
	handle_connecting_signal()
	margin_container.modulate.a = 0.0
	
	var tween = self.create_tween()
	
	blur_animation.play("RESET")
	
	tween.tween_property(margin_container, "modulate:a", 1.0 ,1.0)
	await tween.finished
	tween.stop()
	
	entering_main_menu()

#####
# AUX
#####

func fade(fades_out, fades_in) -> void:
	remove_buttons_focus()
	shield.show()
	
	fades_out.modulate.a = 1.0
	fades_in.modulate.a = 0.0
	
	var tween = self.create_tween()
	
	tween.tween_property(fades_out, "modulate:a", 0.0 ,0.2)
	
	fades_in.show()
	
	tween.tween_property(fades_in, "modulate:a", 1.0 ,0.2)
	
	await tween.finished
	tween.stop()
	
	shield.hide()
	fades_out.hide()

func remove_buttons_focus() -> void:
	if menu.has_focus():
		menu.release_focus()

#####
# Back Pressed
#####

func on_back_setting_menu() -> void: #ao voltar do menu a margem fica visivel e os settings nao
	blur_animation.play("blur_off")
	fade(settings,margin_container)
	
	await get_tree().create_timer(0.5).timeout
	
	settings_button.grab_focus()

func on_back_credits_menu()-> void:
	blur_animation.play("blur_off")
	fade(tela_creditos,margin_container)
	
	await get_tree().create_timer(0.5).timeout
	
	credits_button.grab_focus()

func on_back_warning_popup(value) -> void:
	if value:
		get_tree().quit()
	else:
		leaving_warning_popup()

func leaving_warning_popup() -> void:
	blur_animation.play("blur_off")
	fade(warning_popup,margin_container)
	
	await get_tree().create_timer(0.5).timeout
	
	leave_button.grab_focus()

func entering_main_menu() -> void:
	await get_tree().create_timer(0.5).timeout
	if continue_button.visible:
		continue_button.grab_focus()
	else:
		play_button.grab_focus()

#####
# Back Signals
#####

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu) #Conectar com a func do settings e poder guardar as informações
	tela_creditos.back_credits_menu.connect(on_back_credits_menu)
	warning_popup.option_selected.connect(on_back_warning_popup)

#####
# Pressed Handeling
#####

func _on_continue_pressed() -> void:
	SaveGame.load_game()
	remove_buttons_focus()
	shield.show()
	
	# Som
	menu_click.play()
	
	get_tree().change_scene_to_packed(start_game)

func _on_play_pressed() -> void:
	Global.new_game()
	remove_buttons_focus()
	shield.show()
	
	# Som
	menu_click.play()
	
	get_tree().change_scene_to_packed(start_game)

func _on_settings_pressed() -> void:
	# Som
	menu_click.play()
	# Visualizar
	settings.set_process(true)
	fade(margin_container,settings)
	#Blur
	blur_animation.play("blur_on")
	
	await get_tree().create_timer(0.5).timeout
	
	settings.entering_settings_menu()

func _on_credits_pressed() -> void:
	# Som
	menu_click.play()
	# Visualizar
	tela_creditos.set_process(true)
	fade(margin_container,tela_creditos)
	#Blur
	blur_animation.play("blur_on")
	
	await get_tree().create_timer(0.5).timeout
	
	tela_creditos.entered_credits_menu()

func _on_leave_pressed() -> void:
	# Som
	menu_click.play()
	# Visualizar
	warning_popup.set_process(true)
	fade(margin_container,warning_popup)
	#Blur
	blur_animation.play("blur_on")
	
	warning_popup.change_title("title_warning_leaving","description_warning") # Qualquer dúvida em terminologias, visitar o .CSV
	warning_popup.entering_popup()

#####
# Hover Handeling
#####
func _on_continue_mouse_entered() -> void:
	continue_button.grab_focus()

func _on_play_mouse_entered() -> void:
	play_button.grab_focus()

func _on_settings_mouse_entered() -> void:
	settings_button.grab_focus()

func _on_credits_mouse_entered() -> void:
	credits_button.grab_focus()

func _on_leave_mouse_entered() -> void:
	leave_button.grab_focus()

func _on_focus_entered() -> void:
	menu_hover.play()
