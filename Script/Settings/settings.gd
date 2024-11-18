class_name Settings
extends Control

#Criaçaõ de variaveis para butões e etc
@export var background: ColorRect
@export var margin_container : MarginContainer
# Botões
@export_category("Botões")
@export var back_button: Button
@export var window_button: OptionButton
@export var res_button: OptionButton
@export var language_button: OptionButton

# Language
@onready var current_language = TranslationServer.get_locale()

# Importar sons
@export_category("Efeitos Sonoros")
@export var menu_click: AudioStreamPlayer
@export var menu_hover: AudioStreamPlayer

# Variaveis
const RESOLUTION_MODE_DICTIONARY : Dictionary  = {
	"1920 x 1080" : Vector2i(1920, 1080),
	"1680 x 1050" : Vector2i(1680, 1050),
	"1600 x 900" : Vector2i(1600, 900),
	"1440 x 900" : Vector2i(1440, 900),
	"1366 x 768" : Vector2i(1366, 768),
	"1280 x 1024" : Vector2i(1280, 1024),
	"1280 x 800" : Vector2i(1280, 800),
	"1280 x 720" : Vector2i(1280, 720),
	"1024 x 768" : Vector2i(1024, 768),
	"640 x 480" : Vector2i(640, 480),
	"640 x 360" : Vector2i(640, 360),
	"320 x 240" : Vector2i(320, 240)
}
const WINDOW_MODE_ARRAY : Array[String] = [
	"Window Mode",
	"Full-Screen",
	"Borderless Window",
]
const LANGUAGE_ARRAY : Array[String] = [
	"English",
	"Português",
	"日本語"
]
signal back_setting_menu

func _ready() -> void:
	# Res items
	add_window_mode_items()
	add_res_mode_items()
	# Lan items
	add_language_items()
	
	load_global_values()
	
	set_process(false) #processo feito para cosneguir voltar ao menu e ter as informações

func _process(_delta: float) -> void:
	back_button_input()

func load_global_values() -> void:
	res_button.select(Global.res_screen)
	res_mode_choice(Global.res_screen)
	
	window_button.select(Global.fullscreen)
	window_mode_choice(Global.fullscreen)
	
	language_button.select(Global.language)
	language_choice(Global.language)

######
# Background
######

func backgroundvisible() -> void:
	if background.visible:
		background.hide()
	else:
		background.show()

#####
# Screen Resolution
#####

# ADD ITEMS
func add_window_mode_items() -> void: #fazer um loop for pra analizar o array e ver o window mod correto
	for window_mode in WINDOW_MODE_ARRAY:
		window_button.add_item(window_mode)

func add_res_mode_items() -> void: #fazer um loop for para analizar todas as resuloções existestes e adicionar a correta
	for resolution_size_text in RESOLUTION_MODE_DICTIONARY:
		res_button.add_item(resolution_size_text)

# CARREGAR
func on_res_mode_selected(index : int) -> void: #para alterar a resulotion mod
	menu_click.play()
	res_mode_choice(index)
	Global.res_screen = index

func on_window_mode_selected(index : int) -> void: #para alterar os windows mods
	menu_click.play()
	window_mode_choice(index)
	Global.fullscreen = index

func res_mode_choice(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_MODE_DICTIONARY.values()[index])

func window_mode_choice(index: int) -> void:
	match  index:
		0: #Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Full_Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Borderless window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

#####
# Language
#####

# ADD ITEMS
func add_language_items() -> void:
	for language in LANGUAGE_ARRAY:
		language_button.add_item(language)

# CARREGAR
func on_language_select(index : int) -> void:
	menu_click.play()
	language_choice(index)
	Global.language = index
	fade()

func language_choice(index : int) -> void:
	match index:
		0: #English
			TranslationServer.set_locale("en")
			current_language = "en"
		1: #Português
			TranslationServer.set_locale("pt_PT")
			current_language = "pt_PT"
		2: #日本語
			TranslationServer.set_locale("ja")
			current_language = "ja"

#####
# Back Button
#####

# PRESSED
func _on_back_pressed() -> void:
	back_setting_menu.emit()
	menu_click.play()
	set_process(false)

# HOVER
func _on_back_mouse_entered() -> void:
	menu_hover.play()

######
# fade
######

func fade() -> void:
	margin_container.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(margin_container , "modulate:a", 1.0 , 0.4)
	await tween.finished

######
# gamepad
######

func back_button_input() -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if back_button.has_focus():
			_on_back_pressed()
		else:
			back_button.grab_focus()

func entering_settings_menu() -> void:
	window_button.grab_focus()
