extends Control

@export var parede_vazio : Control
@export var pause_menu : PauseMenu

func _ready() -> void:
	handle_connecting_signal()
	if Global.back_scene:
		parede_vazio.modulate.a = 0.0
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		tween.tween_property(parede_vazio , "modulate:a" , 1.0 , 0.2)
		await tween.finished

func on_back_pause_menu() -> void:
	pause_menu.hide()

func handle_connecting_signal() -> void:
	pause_menu.out_pause_menu.connect(on_back_pause_menu)
