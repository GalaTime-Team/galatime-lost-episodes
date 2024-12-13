extends Control

@export_category("Botões")
@export var left_button : TextureButton
@export var right_button : TextureButton
@export var up_button : TextureButton
@export var down_button : TextureButton

@export_category("Controls")
@export var pause_menu : PauseMenu
@export var sala : Control

@export_category("Sound")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

signal sinal_direcao(value)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	direcao_pressionada()
	esc_pressionado()

func open_pause_menu() -> void:
	if pause_menu.visible:
		pause_menu.resume_game()
		
		var tween = self.create_tween()
		tween.tween_interval(0.2)
		await tween.finished
		tween.stop()
		
		pause_menu.hide()
	elif !pause_menu.visible:
		pause_menu.set_process(true)
		pause_menu.show()
		pause_menu.open_pause_menu()

func _on_settings_button_pressed() -> void:
	menu_click.play()
	open_pause_menu()

func _on_pressed(direcao: String) -> void:
	sala.modulate.a = 1.0
	
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(sala , "modulate:a" , 0.0 , 0.2)
	await tween.finished
	
	Global.back_scene = true
	
	if direcao == "baixo":
		print("voltar")
		emit_signal("sinal_direcao", direcao)
		# Mudar de Sala de volta para onde estavamos antes
	else:
		print("mover")
		emit_signal("sinal_direcao", direcao)
		# Mudar de Sala para uma das direções

#########
# Controlos
#########

func direcao_pressionada():
	if Input.is_action_just_pressed("esquerda"):
		if left_button.visible:
			_on_pressed("esquerda")
	elif Input.is_action_just_pressed("direita"):
		if right_button.visible:
			_on_pressed("direita")
	elif Input.is_action_just_pressed("cima"):
		if up_button.visible:
			_on_pressed("cima")
	elif Input.is_action_just_pressed("afastar"):
		if down_button.visible:
			_on_pressed("baixo")

func esc_pressionado():
	if Input.is_action_just_pressed("escape"):
		open_pause_menu()


func _on_settings_button_mouse_entered() -> void:
	menu_hover.play()
