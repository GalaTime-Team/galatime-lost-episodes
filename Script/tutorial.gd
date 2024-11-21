class_name Tutorial
extends Control

@export var tutorial: Tutorial
@export var blur: AnimationPlayer
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blur.play("RESET")
	set_process(false)
	

func _on_button_pressed() -> void: #se for clicado no botão ele vai desaparecendo lentamente
	menu_click.play()
	
	tutorial.modulate.a = 1.0
	
	var tween = self.create_tween()
	tween.tween_property(tutorial, "modulate:a", 0.0, 0.4)
	await tween.finished
	tween.stop()
	
	self.hide()

func fade_in() -> void: #func para ao acabr o intro monologo e entrar na sala aparece o tutorial com o fade
	tutorial.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_property(tutorial, "modulate:a", 1.0, 0.5)
	self.show()
	await tween.finished

func _on_button_mouse_entered() -> void:
	menu_hover.play()
