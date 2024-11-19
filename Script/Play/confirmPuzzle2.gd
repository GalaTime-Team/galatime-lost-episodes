extends Button

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var puzzle_complet: AudioStreamPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	if !Global.puzzle2_complete:
		if b1.text == "6" and b2.text == "1" and b3.text == "0":
			puzzle_complet.play()
			Global.puzzle2_complete = true
