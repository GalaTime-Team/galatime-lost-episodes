extends Control

@export var pause_menu : PauseMenu
@export var sala : Control

func _ready() -> void:
	handle_connecting_signal()
	if Global.back_scene:
		sala.modulate.a = 0.0
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		tween.tween_property(sala , "modulate:a" , 1.0 , 0.2)
		await tween.finished

func _process(_delta: float) -> void:
	testEsc()

func on_back_pause_menu() -> void:
	pause_menu.hide()

func handle_connecting_signal() -> void:
	pause_menu.out_pause_menu.connect(on_back_pause_menu)

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

func testEsc():
	if Input.is_action_just_pressed("escape"):
		_on_texture_button_pressed()
