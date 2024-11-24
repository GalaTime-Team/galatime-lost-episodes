class_name Warning_Popup
extends Control

@export var warning_popup : Warning_Popup
@export var warning_title : Label
@export var warning_description : Label

@export_category("Butões")
@export var yes_button : Button
@export var no_button : Button

@export_category("Sons")
@export var menu_hover : AudioStreamPlayer
@export var menu_click : AudioStreamPlayer

signal option_selected(value)

func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	button_pressed()

func remove_buttons_focus() -> void:
	if warning_popup.has_focus():
		warning_popup.release_focus()


########
# AUX
########

func title(title: String, description: String):
	warning_title.text = title
	warning_description.text = description

######
# Press
######

func _on_yes_pressed() -> void:
	remove_buttons_focus()
	menu_click.play()
	emit_signal("option_selected", true)
	set_process(false)

func _on_no_pressed() -> void:
	remove_buttons_focus()
	menu_click.play()
	emit_signal("option_selected", false)
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
