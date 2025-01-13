extends Button

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var chave : Button
@export var puzzle_complet: AudioStreamPlayer

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	if !Global.puzzle1_complete:
		if b1.text == "4" and b2.text == "5" and b3.text == "1":
			puzzle_complet.play()
			Global.puzzle1_complete = true
			chave.show()
