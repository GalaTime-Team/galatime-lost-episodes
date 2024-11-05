class_name TelaCreditos
extends Control

@export var back: Button

# Importar sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

signal back_credits_menu 

func _ready():
	set_process(false)

######
# Buttons pressed
######

func _on_back_pressed() -> void:
	back_credits_menu.emit()
	menu_click.play()
	set_process(false)

func _on_back_mouse_entered() -> void:
	menu_hover.play()
