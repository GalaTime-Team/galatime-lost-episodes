extends Control

@onready var margin_container: MarginContainer = $MarginContainer
@onready var intro_monologue: IntroMonologue = $IntroMonologue
@onready var pause_menu: Control = $CanvasLayer/PauseMenu

func _ready() -> void:
	intro_monologue.visible = true
	handle_connecting_signal()

func on_intro_monologue() -> void:
	# Visualizar
	margin_container.visible = false
	intro_monologue.set_process(true)
	intro_monologue.visible = true  # Ensure it's visible when starting

func handle_connecting_signal() -> void:
	intro_monologue.back_dialog.connect(fade)
	pause_menu.leaving_menu.connect(_on_leaving_pause_menu)
	

func fade() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 2.0)
	await tween.finished
	intro_monologue.visible = false  # Change visibility after tween finishes

func _on_button_settings_pressed() -> void:
	pause_menu.modulate.a = 0.0
	pause_menu.visible = true
	var tween = self.create_tween()
	tween.tween_property(pause_menu, "modulate:a", 1.0 ,0.2)
	await tween.tween_interval(0.2)

func _on_leaving_pause_menu() -> void:
	var tween = self.create_tween()
	tween.tween_property(pause_menu, "modulate:a", 0.0 ,0.2)
	await tween.tween_interval(0.2)
	pause_menu.visible = false
