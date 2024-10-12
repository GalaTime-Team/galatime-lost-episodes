class_name Settings
extends Control

@onready var back_button = $MarginContainer/Back as Button

signal back_setting_menu

# Função chamada quando a cena entra pela primeira vez
func _ready() -> void:
	back_button.button_down.connect(on_back_pressed)
	set_process(false)

func on_back_pressed() -> void:
	back_setting_menu.emit()
	set_process(false)
