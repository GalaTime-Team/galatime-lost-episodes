extends Control

@onready var margin_container: MarginContainer = $MarginContainer
@onready var intro_monologue: IntroMonologue = $IntroMonologue

signal back_dialog

func _ready() -> void:
	handle_connecting_signal()

func on_intro_monologue() -> void:
	# Visualizar
	margin_container.visible = false
	intro_monologue.set_process(true)
	intro_monologue.visible = true  # Ensure it's visible when starting

func handle_connecting_signal() -> void:
	intro_monologue.back_dialog.connect(fade)

func fade() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 2.0)
	print("suka")
	await tween.finished
	intro_monologue.visible = false  # Change visibility after tween finishes
	
