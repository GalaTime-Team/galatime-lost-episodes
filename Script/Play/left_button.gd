extends TextureButton

@export var sala : Control

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	press_esquerda()

func _on_pressed() -> void:
	sala.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	Global.cena_direcao("esquerda")

func press_esquerda():
	if Input.is_action_just_pressed("esquerda"):
		_on_pressed()
