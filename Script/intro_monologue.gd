class_name IntroMonologue
extends Control

@onready var margin_container: MarginContainer = $MarginContainer
var intromonologue = "intromonologue"

signal back_dialog

func _ready() -> void:
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	await tween.finished
	if !Global.monologuecont:
		start_monologue()

########
# monologue
########

func start_monologue():
	Dialogic.signal_event.connect(end_of_dialog)
	Dialogic.start(intromonologue)

func end_of_dialog(argument : String):
	if argument == "end_of_dialogue":
		set_process(false)
		back_dialog.emit()
