extends AudioStreamPlayer

@export var timer: Timer 

@export var music_player: AudioStreamPlayer


var music_list : Array = [] # Lista de músicas
var current_music_index : int = 0 # Índice da música atual

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	music_list = [
	preload("C:/Users/PC/OneDrive/Documents/GitHub/galatime-lost-episodes/Asset/Audio/Music/Outside The Room.mp3"),
	preload("C:/Users/PC/OneDrive/Documents/GitHub/galatime-lost-episodes/Asset/Audio/Music/Lost Episode.mp3"),
	preload("C:/Users/PC/OneDrive/Documents/GitHub/galatime-lost-episodes/Asset/Audio/Music/GalaTime Lost Episodes Theme.mp3")
	]
	music_player._on_music_finished.connect("finished",self)
	timer.on_Timer_timeout.connect("timeout",self)
	play_music()
	

# Função chamada quando a música termina
func _on_music_finished():
# Troca para a próxima música na lista
	play_music()

# Função para tocar a próxima música
func play_music():
	music_player.stream = music_list[current_music_index]
	music_player.play()
	print("Tocando: " + music_list[current_music_index].resource_path)
	
	# Aumenta o índice para a próxima música
	current_music_index = (current_music_index + 1) % music_list.size()
	
	var delay = randi() % 20 + 1
	timer.wait_time = delay  # Define o tempo de espera aleatório
	timer.start()  # Inicia o timer


# Função para quando acaba o timer
func _on_Timer_timeout():
	play_music()

func _on_finished() -> void:
	var delay = randi() % 20 + 1
	timer.wait_time = delay
	timer.start()
