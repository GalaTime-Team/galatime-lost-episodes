extends Control

@export var parede_vermelha : Control
@export var pause_menu : PauseMenu
var puzzle1 = load("res://Interface/Play/puzzle1-Sala_vermelha.tscn")

func _ready() -> void:
	handle_connecting_signal()
	Global.sala_que_estamos = "vermelha"
	if Global.back_scene:
		parede_vermelha.modulate.a = 0.0
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		tween.tween_property(parede_vermelha , "modulate:a" , 1.0 , 0.2)
		await tween.finished

func on_back_pause_menu() -> void:
	pause_menu.hide()

func handle_connecting_signal() -> void:
	pause_menu.out_pause_menu.connect(on_back_pause_menu)

func _on_box_button_pressed() -> void:
	parede_vermelha.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(parede_vermelha , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	get_tree().change_scene_to_packed(puzzle1)
