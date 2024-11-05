extends Control

@export var sala_vermelha : Control

func _ready() -> void:
	sala_vermelha.modulate.a = 0.0
	Global.sala_que_estamos = "vermelha"
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vermelha , "modulate:a" , 1.0 , 0.2)
	await tween.finished

func _on_right_button_pressed() -> void:
	sala_vermelha.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vermelha , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	Global.cena_direcao("direita")

func _on_left_button_pressed() -> void:
	sala_vermelha.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vermelha , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	Global.cena_direcao("esquerda")

func _on_up_button_pressed() -> void:
	sala_vermelha.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vermelha , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	Global.cena_direcao("cima")
