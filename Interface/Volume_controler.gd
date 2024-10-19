extends Control

@onready var audio_name = $HBoxContainer/Audio_Name as Label
@onready var audio_num = $HBoxContainer/Audio_Num as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider

@export_enum("Master" , "Music" , "Sfx") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed) #mudar o valor do volume
	get_bus_name_by_index() #pegar o nome da bus pelo index 
	set_name_label() #ver o nome daas labes
	set_slider_value() #mudar o volume do slider volume

func on_value_changed(value : float) -> void: # ira mudar no valor do hslider pro audioserver 
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_num_label()

func set_slider_value() -> void: # ira mudar no valor do audioserver pro hslider
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_num_label()

func set_name_label() -> void: #func para verificar qual bus_volume esta sendo usado
	audio_name.text = str(bus_name) + " Volume" 

func set_num_label() ->void: #func para pegar o valor do hslider
	audio_num.text = str(h_slider.value * 100)

func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
