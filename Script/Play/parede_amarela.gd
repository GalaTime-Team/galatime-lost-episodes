extends Control

#########
# variavels
#########

@export var parede_amarela : Control
@export var sala: MarginContainer
@export var intro_monologue: IntroMonologue
@export var pause_menu: PauseMenu
@export var tutorial: Tutorial
#########
# READY/PROCESS
#########

func _ready() -> void:
	if !Global.monologuecont:
		on_intro_monologue()
	handle_connecting_signal()

	#fade para voltar para a sala amarela
	if Global.back_scene:
		parede_amarela.modulate.a = 0.0
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		tween.tween_property(parede_amarela , "modulate:a" , 1.0 , 0.2)
		tween.tween_interval(0.2)
		Global.back_scene = false

########
# Monologue
########

func on_intro_monologue() -> void:
	# Visualizar
	intro_monologue.set_process(true)
	intro_monologue.show()  # Ensure it's visible when starting

#########
# conection
#########

func handle_connecting_signal() -> void:
	intro_monologue.back_dialog.connect(end_of_dialogue)
	pause_menu.out_pause_menu.connect(on_back_pause_menu)
#######
# button pause_menu
#######

func on_back_pause_menu() -> void:
	pause_menu.hide()

#######
# EO Dialogue
#######

func end_of_dialogue() -> void:
	opening_eyes_animation()
	Global.monologuecont = true

func opening_eyes_animation() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 1.5)
	await tween.finished
	intro_monologue.hide()
	tutorial.fade_in()
