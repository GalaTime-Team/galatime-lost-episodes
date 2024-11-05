extends Control

@export var sala_vazia : Control

func _ready() -> void:
	sala_vazia.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vazia , "modulate:a" , 1.0 , 0.2)
	await tween.finished

func _on_down_button_pressed() -> void:
	sala_vazia.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vazia , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	Global.mudar_sala(Global.sala_que_estamos)
