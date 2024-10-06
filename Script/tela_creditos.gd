extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button))


# Função chamada quando um botão é pressionado
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Back":
			get_tree().change_scene_to_file("res://Interface/menu.tscn")
