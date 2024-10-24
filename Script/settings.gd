class_name Settings
extends Control

#Criaçaõ de variaveis para butões e etc
@onready var back_button: Button = $MarginContainer/Back
@onready var window_button: OptionButton = $MarginContainer/Conteudo/Settings/ScreenRes/WindowMode/Window_button
@onready var res_button: OptionButton = $MarginContainer/Conteudo/Settings/ScreenRes/ResolutionMode/Res_button
@onready var language_button: OptionButton = $MarginContainer/Conteudo/Settings/LanguageV/Language/language_button
@onready var current_language = TranslationServer.get_locale()

# Importar sons
@onready var s_menu_click: AudioStreamPlayer = $s_menu_click
@onready var s_menu_hover: AudioStreamPlayer = $s_menu_hover

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
	"Português",
	"English",
	"日本語"
]
signal back_setting_menu

func _ready() -> void:
	# Res items
	add_window_mode_items()
	add_res_mode_items()
	# Lan items
	add_language_items()
	
	res_button.item_selected.connect(on_res_mode_selected)
	window_button.item_selected.connect(on_window_mode_selected)
	language_button.item_selected.connect(on_language_select)
	
	set_process(false) #processo feito para cosneguir voltar ao menu e ter as informações

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
	s_menu_click.play()
	DisplayServer.window_set_size(RESOLUTION_MODE_DICTIONARY.values()[index])

func on_window_mode_selected(index : int) -> void: #para alterar os windows mods
	s_menu_click.play()
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
	s_menu_click.play()
	match index:
		0: #Português
			TranslationServer.set_locale("pt_PT")
			current_language = "pt_PT"
		1: #English
			TranslationServer.set_locale("en")
			current_language = "en"
		2: #日本語
			TranslationServer.set_locale("ja")
			current_language = "ja"

#####
# Back Button
#####

# PRESSED
func _on_back_pressed() -> void:
	back_setting_menu.emit()
	s_menu_click.play()
	set_process(false)

# HOVER
func _on_back_mouse_entered() -> void:
	s_menu_hover.play()
