extends Control

signal leaving_menu

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume():
	leaving_menu.emit()

func options():
	$Settings.visible = true
	$PanelContainer/Pause_Options_Container.visible = false

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options()

func _on_leave_pressed() -> void:
	get_tree().quit()
