class_name Tutorial
extends Control

@export var tutorial: Tutorial
@export var blur: AnimationPlayer
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

func _ready() -> void:
	blur.play("RESET")
	set_process(false)
	

func _on_button_pressed() -> void: #se for clicado no botão ele vai desaparecendo lentamente
	menu_click.play()
	
	tutorial.modulate.a = 1.0
	blur.play("blur_off")
	var tween = self.create_tween()
	tween.tween_property(tutorial, "modulate:a", 0.0, 0.4)
	await tween.finished
	tween.stop()
	self.hide()
	Global.monologuecont = true

func fade_in() -> void: #func para ao acabar o monologo e entrar na sala aparece o tutorial com o fade
	tutorial.modulate.a = 0.0
	blur.play("blur_on")
	var tween = self.create_tween()
	tween.tween_property(tutorial, "modulate:a", 1.0, 0.5)
	self.show()
	await tween.finished

func _on_button_mouse_entered() -> void:
	menu_hover.play()
