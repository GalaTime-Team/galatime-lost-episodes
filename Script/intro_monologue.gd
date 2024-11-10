class_name IntroMonologue
extends Control
@export var fogo: AudioStreamPlayer 
@export var chuva: AudioStreamPlayer 

@export var margin_container: MarginContainer
var intromonologue = "intromonologue"

signal back_dialog

func _ready() -> void:
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	await tween.finished
	if !Global.monologuecont:
		start_monologue()
		chuva.play()

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
		fogo.stop()
		chuva.stop()
	elif argument == "fogo":
		#var tween = self.create_tween()
		#tween.tween_property(chuva, "volume_db", -5, -10, 2, Tween.EASE_IN_OUT, 0)
		#await tween.finished
		fogo.play()
