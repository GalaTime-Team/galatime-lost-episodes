extends Control

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	SaveGame.save_game()
	Global.continuarConfirmar = true
