class_name TelaCreditos
extends Control

@onready var back: Button =  $MarginContainer/Back

# Importar sons
@onready var s_menu_click: AudioStreamPlayer = $s_menu_click
@onready var s_menu_hover: AudioStreamPlayer = $s_menu_hover

signal back_credits_menu 

func _ready():
	set_process(false)

######
# Buttons pressed
######

func _on_back_pressed() -> void:
	back_credits_menu.emit()
	s_menu_click.play()
	set_process(false)

func _on_back_mouse_entered() -> void:
	s_menu_hover.play()
