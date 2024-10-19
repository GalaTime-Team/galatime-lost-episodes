class_name Settings #nome do script/class
extends Control

#Criaçaõ de variaveis para butões e etc
@onready var back_button = $MarginContainer/Back as Button
@onready var window_button = $MarginContainer/VBoxContainer/WindowMode/Window_button as OptionButton
@onready var res_button = $MarginContainer/VBoxContainer/ResolutionMode/Res_button as OptionButton

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

signal back_setting_menu

# Função chamada quando a cena entra pela primeira vez
func _ready() -> void:
	add_window_mode_items() #os windows mods para conseguirem ser alterados
	add_res_mode_items() #as resulotions mods para conseguirem ser alteradas
	res_button.item_selected.connect(on_res_mode_selected)
	window_button.item_selected.connect(on_window_mode_selected)
	back_button.button_down.connect(on_back_pressed)
	set_process(false) #processo feito para cosneguir voltar ao menu e ter as informações

func on_back_pressed() -> void: #func do processo que ira ser feito no menu
	back_setting_menu.emit()
	set_process(false)

func add_window_mode_items() -> void: #fazer um loop for pra analizar o array e ver o window mod correto
	for window_mode in WINDOW_MODE_ARRAY:
		window_button.add_item(window_mode)
		
func add_res_mode_items() -> void: #fazer um loop for para analizar todas as resuloções existestes e adicionar a correta
	for resolution_size_text in RESOLUTION_MODE_DICTIONARY:
		res_button.add_item(resolution_size_text)
		
func on_res_mode_selected(index : int) -> void: #para alterar a resulotion mod
	DisplayServer.window_set_size(RESOLUTION_MODE_DICTIONARY.values()[index])
			
	
func on_window_mode_selected(index : int) -> void: #para alterar os windows mods
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
