extends Control

#######
# audios variabels
########
@export var audio_name : Label
@export var audio_num : Label
@export var h_slider : HSlider
@export var s_menu_click: AudioStreamPlayer

# Exported bus names
@export_enum("Master" , "Music" , "Sfx") var bus_name : String

#######
# bus index
#######
var bus_index : int = 0

var bus_labels = {
	"Master": "label_settings_master_volume",
	"Music": "label_settings_music_volume",
	"Sfx": "label_settings_sound_effects"
}

func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed) #mudar o valor do volume
	get_bus_name_by_index() #pegar o nome da bus pelo index 
	set_name_label() #ver o nome daas labes
	set_slider_value() #mudar o volume do slider volume

########
# set value bus
########

func on_value_changed(value : float) -> void: # ira mudar no valor do hslider pro audioserver 
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_num_label()

######
# set labels
######

func set_slider_value() -> void: #
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_num_label()

func set_name_label() -> void:
	audio_name.text = bus_labels.get(bus_name, "label_settings_sound_effects")

func set_num_label() -> void:
	audio_num.text = str(int(round(h_slider.value * 100)))

#######
# bus
#######

func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

######
# slider sound
#####

func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	s_menu_click.play()
