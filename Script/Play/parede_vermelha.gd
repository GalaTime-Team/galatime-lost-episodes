extends Control 
@export var parede_vermelha : Control 
var puzzle1 = load("res://Interface/Play/puzzle1-Sala_vermelha.tscn").instantiate() 

func _ready() -> void: 
	add_child(puzzle1) 
	puzzle1.hide() 

func _on_box_button_pressed() -> void: 
	fade(parede_vermelha, puzzle1) 

func fade(fades_out, fades_in) -> void: 
	fades_out.modulate.a = 1.0 
	fades_in.modulate.a = 0.0 
	var tween = create_tween() 
	tween.tween_property(fades_out, "modulate:a", 0.0 ,0.2)
	fades_in.show() 
	tween.tween_property(fades_in, "modulate:a", 1.0 ,0.2) 
	await tween.finished 
	tween.stop() 
	fades_out.hide()
