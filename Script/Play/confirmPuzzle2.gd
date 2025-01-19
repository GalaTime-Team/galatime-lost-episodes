extends Button

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button
@export var papel : Button
@export var puzzle_complet: AudioStreamPlayer

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	if not Global.puzzles["puzzle2"].completo:
		if b1.text == Global.puzzles["puzzle2"].solucao[0] and b2.text == Global.puzzles["puzzle2"].solucao[1] and b3.text == Global.puzzles["puzzle2"].solucao[2]:
			puzzle_complet.play()
			Global.puzzles["puzzle2"].completo = true
			papel.show()
