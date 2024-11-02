extends TextureButton

@export var sala_amarela : Control

var scene = load("res://Interface/Sala_vermelha.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_pressed() -> void:
	fade()

#######
# fade
#######

func fade() -> void:
	sala_amarela.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_amarela , "modulate:a" , 0.0 , 0.2)
	tween.tween_interval(0.2)
	await tween.finished
	get_tree().change_scene_to_packed(scene)
	
