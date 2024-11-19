extends Control

@export var sala_azul : Control
@export var pause_menu : PauseMenu
var puzzle2 = load("res://Interface/Play/puzzle2-Sala_azul.tscn")

func _ready() -> void:
	handle_connecting_signal()
	Global.sala_que_estamos = "azul"
	if Global.back_scene:
		sala_azul.modulate.a = 0.0
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		tween.tween_property(sala_azul , "modulate:a" , 1.0 , 0.2)
		await tween.finished

func _process(_delta: float) -> void:
	testEsc()

func _on_texture_button_pressed() -> void:
	pause_menu.set_process(true)
	if pause_menu.visible:
		pause_menu.resume_game()
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		await tween.finished
		tween.stop()
		pause_menu.hide()
	elif !pause_menu.visible:
		pause_menu.show()
		pause_menu.open_pause_menu()

func on_back_pause_menu() -> void:
	pause_menu.hide()

func handle_connecting_signal() -> void:
	pause_menu.out_pause_menu.connect(on_back_pause_menu)

func testEsc():
	if Input.is_action_just_pressed("escape"):
		_on_texture_button_pressed()

func _on_button_pressed() -> void:
	sala_azul.modulate.a = 1.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala_azul , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	Global.back_scene = true
	get_tree().change_scene_to_packed(puzzle2)
