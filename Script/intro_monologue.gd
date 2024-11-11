class_name IntroMonologue
extends Control
@export var fogo : AudioStreamPlayer 
@export var chuva : AudioStreamPlayer 
@export var fundo : AudioStreamPlayer

@export var margin_container: MarginContainer
var intromonologue = "intromonologue"

signal back_dialog

func _ready() -> void:
	var tween = self.create_tween()
	tween.tween_interval(1.0) #intervalo
	await tween.finished
	tween.stop()
	if !Global.monologuecont:
		start_monologue()
		
		chuva.volume_db = -80
		chuva.play()
		
		var tween2 = self.create_tween()
		tween2.tween_property(chuva, "volume_db", -5, 1.0)
		await tween2.finished
		tween2.stop()

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
		var tween = self.create_tween()
		tween.tween_property(chuva, "volume_db", -80, 2.0)
		tween.tween_property(fogo, "volume_db", -80, 2.0)
		tween.tween_property(fundo , "volume_db", -80, 2.0)
		await tween.finished
		tween.stop()
		fogo.stop()
		chuva.stop()
		fundo.stop()
	elif argument == "fogo":
		var tween = self.create_tween()
		tween.tween_property(chuva, "volume_db", -7, 1.0)
		fogo.volume_db = -80
		fogo.play()
		tween.tween_property(fogo, "volume_db", -11, 2.0)
		await tween.finished
		tween.stop()
