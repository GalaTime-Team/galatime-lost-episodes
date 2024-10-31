extends Control

#########
# variavels
#########

@export var sala: MarginContainer
@export var intro_monologue: IntroMonologue
@export var pause_menu: PauseMenu

func _ready() -> void:
	intro_monologue.visible = true
	handle_connecting_signal()

########
# monologue
########

func on_intro_monologue() -> void:
	# Visualizar
	sala.visible = false
	intro_monologue.set_process(true)
	intro_monologue.visible = true  # Ensure it's visible when starting

#########
# conection
#########

func handle_connecting_signal() -> void:
	intro_monologue.back_dialog.connect(fade)

#######
# fade
#######

func fade() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 2.0)
	await tween.finished
	intro_monologue.visible = false  # Change visibility after tween finishes
