extends Control

@export var pause_menu : PauseMenu
@export var sala : Control
@export var puzzle: Control

func _ready() -> void:
	set_process(false)


func on_back_pause_menu() -> void:
	pause_menu.hide()

func handle_connecting_signal() -> void:
	pause_menu.out_pause_menu.connect(on_back_pause_menu)
