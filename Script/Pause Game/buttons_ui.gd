extends Control

@export_category("Botões")
@export var left_button : TextureButton
@export var right_button : TextureButton
@export var up_button : TextureButton
@export var down_button : TextureButton

@export_category("Controls")
@export var pause_menu : PauseMenu

@export_category("Sound")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

signal sinal_direcao(value)

func _ready() -> void:
	handling_signals()

func _process(_delta: float) -> void:
	if Global.monologuecont:
		direcao_pressionada()
		esc_pressionado()

func open_pause_menu() -> void:
	if pause_menu.visible:
		pause_menu.resume_game_animation()
		pause_menu.set_process(false)
		
		await get_tree().create_timer(0.3).timeout
		
		pause_menu.hide()
	elif !pause_menu.visible:
		pause_menu.set_process(true)
		pause_menu.show()
		pause_menu.open_pause_menu()

func _on_settings_button_pressed() -> void:
	menu_click.play()
	open_pause_menu()

func _on_pressed(direcao: String) -> void:
	if direcao == "baixo":
		emit_signal("sinal_direcao", direcao)
		# Mudar de Sala de volta para onde estavamos antes
	else:
		emit_signal("sinal_direcao", direcao)
		# Mudar de Sala para uma das direções

func handling_signals() -> void:
	pause_menu.out_pause_menu.connect(open_pause_menu)

#########
# Controlos
#########

func direcao_pressionada():
	if Input.is_action_just_pressed("esquerda") and left_button.visible:
			_on_pressed("esquerda")
	elif Input.is_action_just_pressed("direita") and right_button.visible:
			_on_pressed("direita")
	elif Input.is_action_just_pressed("cima") and up_button.visible:
			_on_pressed("cima")
	elif Input.is_action_just_pressed("afastar") and down_button.visible:
			_on_pressed("baixo")

func esc_pressionado():
	if Input.is_action_just_pressed("escape"):
		open_pause_menu()

func _on_settings_button_mouse_entered() -> void:
	menu_hover.play()
