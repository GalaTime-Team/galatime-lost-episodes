extends TextureButton

@export var sala_vazia : Control

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	press_baixo()

func _on_pressed() -> void:
	sala_vazia.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_vazia , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	Global.mudar_sala(Global.sala_que_estamos)

func press_baixo():
	if Input.is_action_just_pressed("afastar"):
		_on_pressed()
