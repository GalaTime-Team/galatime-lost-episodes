class_name TelaCreditos
extends Control

@export var back_button: Button

# Importar sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

signal back_credits_menu 

func _ready():
	set_process(false)

func _process(_delta: float) -> void:
	back_button_input()

######
# Buttons pressed
######

func _on_back_pressed() -> void:
	back_button.release_focus()
	back_credits_menu.emit()
	menu_click.play()
	set_process(false)

func back_button_input() -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_pressed()

func entered_credits_menu():
	back_button.grab_focus()

func _on_back_focus_entered() -> void:
	menu_hover.play()
