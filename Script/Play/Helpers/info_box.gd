class_name blocoDeAcao
extends Control

func _ready() -> void:
	pass

func _on_gui_input(event: InputEvent, arg_timeline: String) -> void:
	if event.is_action_pressed("info") and event.is_pressed():
		Dialogic.start(arg_timeline)
