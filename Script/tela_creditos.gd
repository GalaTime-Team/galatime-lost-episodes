class_name TelaCreditos
extends Control

signal back_credits_menu 
@onready var back  =  $MarginContainer/Back as Button

# Importar sons
@onready var s_menu_click: AudioStreamPlayer = $s_menu_click
@onready var s_menu_hover: AudioStreamPlayer = $s_menu_hover

func _ready():
	set_process(false)


func _on_back_pressed() -> void:
	back_credits_menu.emit()
	s_menu_click.play()
	set_process(false)


func _on_back_mouse_entered() -> void:
	s_menu_hover.play()
