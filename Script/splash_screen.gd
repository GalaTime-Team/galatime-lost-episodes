extends Control

@export var load_scene : PackedScene
@export var in_time : float = 0.5
@export var fade_in_time : float = 1.5
@export var pause_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 1.0
@export var splash_screen : ColorRect

func _ready() -> void:
	fade()

func fade() -> void:
	splash_screen.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(in_time) #intervalos
	tween.tween_property(splash_screen, "modulate:a", 0.0 ,fade_in_time) #fazer aparecer a imagem
	tween.tween_interval(pause_time) #intervalos
	tween.tween_property(splash_screen, "modulate:a", 1.0 , fade_out_time) #fazer transparecer a imgem
	tween.tween_interval(out_time) #intervalos
	await tween.finished
	get_tree().change_scene_to_packed(load_scene)
