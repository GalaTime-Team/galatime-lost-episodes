class_name Warning_Popup
extends Control

@export_category("Butões")
@export var yes_button : Button
@export var no_button : Button

@export_category("Sons")
@export var menu_hover : AudioStreamPlayer
@export var menu_click : AudioStreamPlayer

signal back_popup_menu

func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	button_pressed()

######
# Press
######

func _on_yes_pressed() -> void:
	get_tree().quit()

func _on_no_pressed() -> void:
	menu_click.play()
	back_popup_menu.emit()
	set_process(false)

######
# Hover
######

func _on_yes_mouse_entered() -> void:
	menu_hover.play()

func _on_no_mouse_entered() -> void:
	menu_hover.play()

######
# Gamepad
######

func button_pressed():
	if Input.is_action_just_pressed("ui_cancel"):
		_on_no_pressed()

func entering_popup():
	yes_button.grab_focus()
