class_name PauseMenu
extends Control

@export var blur_animation: AnimationPlayer
@export var shield: PanelContainer
@export var pauseMenu: PauseMenu

@export_category("Páginas")
@export var settings: Settings
@export var inventory: Inventory
@export var panel_container: PanelContainer
@export var warning_popup: Warning_Popup

# Importar Sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

@onready var splash_screen : PackedScene = load("res://Interface/splash_screen.tscn")

signal out_pause_menu

#####
# AUX
#####


func remove_buttons_focus() -> void:
	if pauseMenu.has_focus():
		pauseMenu.release_focus()

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
	
	fades_out.hide()
	shield.hide()


#####
# Ready // Process
#####

func _ready() -> void:
	blur_animation.play("RESET")
	
	handle_connecting_signal()
	set_process(false)

#####
# Main Options
#####

func open_pause_menu():
	panel_container.modulate.a = 0.0
	panel_container.show()
	
	# Animação
	var tween = self.create_tween()
	blur_animation.play("blur_on")
	tween.tween_property(panel_container, "modulate:a", 1.0 ,0.2)
	await tween.finished
	shield.hide()

func resume_game_animation():
	remove_buttons_focus()
	shield.show()
	
	# Garantir Valores
	panel_container.show()
	panel_container.modulate.a = 1.0
	
	# Animação
	var tween = self.create_tween()
	blur_animation.play("blur_off")
	tween.tween_property(panel_container, "modulate:a", 0.0 ,0.2)
	await tween.finished
	
	panel_container.hide()

func resume_game():
	out_pause_menu.emit()

func options():
	settings.set_process(true)
	settings.background.show()
	
	fade(panel_container, settings)
	
	await get_tree().create_timer(0.5).timeout
	
	settings.entering_settings_menu()

func items():
	inventory.set_process(true)
	
	inventory.listaritem()
	
	fade(panel_container, inventory)

func warningpopup():
	warning_popup.set_process(true)
	
	fade(panel_container, warning_popup)
	
	await get_tree().create_timer(0.5).timeout
	
	warning_popup.entering_popup()

########
# Voltar ao Pause_Menu
########

func on_back_setting_menu() -> void:
	fade(settings, panel_container)

func on_back_inventory() -> void:
	fade(inventory, panel_container)

func on_back_warningpopup(value) -> void:
	if value:
		get_tree().change_scene_to_packed(splash_screen)
	else:
		leaving_warning_popup()

func leaving_warning_popup() -> void:
	fade(warning_popup, panel_container)
	
	await get_tree().create_timer(0.5).timeout

func handle_connecting_signal() -> void:
	settings.back_setting_menu.connect(on_back_setting_menu)
	inventory.back_inventory_menu.connect(on_back_inventory)
	warning_popup.option_selected.connect(on_back_warningpopup)

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

func _on_items_pressed() -> void:
	menu_click.play()
	items()

func _on_leave_pressed() -> void:
	menu_click.play()
	warning_popup.change_title("title_warning_restarting_game","description_warning")
	warningpopup()

func _on_texture_button_pressed() -> void:
	resume_game()

# Hover Sounds

func _on_resume_mouse_entered() -> void:
	menu_hover.play()

func _on_options_mouse_entered() -> void:
	menu_hover.play()

func _on_items_mouse_entered() -> void:
	menu_hover.play()

func _on_leave_mouse_entered() -> void:
	menu_hover.play()
