extends Control

#########
# variavels
#########

@export var sala_amarela : Control
@export var sala: MarginContainer
@export var intro_monologue: IntroMonologue
@export var pause_menu: PauseMenu

func _ready() -> void:
	if !Global.monologuecont:
		on_intro_monologue()
	handle_connecting_signal()
	
	#fade para voltar para a sala amarela
	if Global.back_scene == true:
		sala_amarela.modulate.a = 0.0
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		tween.tween_property(sala_amarela , "modulate:a" , 1.0 , 0.2)
		tween.tween_interval(0.2)
		Global.back_scene = false

########
# monologue
########

func on_intro_monologue() -> void:
	# Visualizar
	intro_monologue.set_process(true)
	intro_monologue.visible = true  # Ensure it's visible when starting

#########
# conection
#########

func handle_connecting_signal() -> void:
	intro_monologue.back_dialog.connect(end_of_dialogue)
	pause_menu.out_pause_menu.connect(on_back_pause_menu)
	
#######
# buttun pause_menu
#######

func on_back_pause_menu() -> void:
	pause_menu.visible = false

func _on_texture_button_pressed() -> void:
	pause_menu.set_process(true)
	if pause_menu.visible:
		pause_menu.resume_game()
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		await tween.finished
		tween.stop()
		pause_menu.hide()
	elif !pause_menu.visible:
		pause_menu.show()
		pause_menu.open_pause_menu()

#######
# fade
#######

func fade() -> void:
	intro_monologue.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	tween.tween_property(intro_monologue, "modulate:a", 0.0, 2.0)
	await tween.finished
	intro_monologue.hide()  # Change visibility after tween finishes

#######
# escape
#######

func testEsc():
	if Input.is_action_just_pressed("escape") and pause_menu.visible == false:
		_on_texture_button_pressed()

func _process(_delta: float) -> void:
	testEsc()

func end_of_dialogue() -> void:
	fade()
	Global.monologuecont = true
