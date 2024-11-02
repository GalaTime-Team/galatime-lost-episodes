extends Control

@export var sala_vermelha : Control
var scene = load("res://Interface/Sala_Amarela.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sala_vermelha.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vermelha , "modulate:a" , 1.0 , 0.2)
	tween.tween_interval(0.2)
	await tween.finished

func _on_right_button_pressed() -> void:
	sala_vermelha.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vermelha , "modulate:a" , 0.0 , 0.2)
	tween.tween_interval(0.2)
	await tween.finished
	Global.back_scene = true
	get_tree().change_scene_to_packed(scene)
