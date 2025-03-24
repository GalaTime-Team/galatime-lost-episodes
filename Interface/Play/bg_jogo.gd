extends AudioStreamPlayer

@export var timer: Timer 

var pausado : bool = false
var posicao : float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_music()
	

# Função chamada quando a música termina
func _on_music_finished():
	play_music()

# Função para tocar a próxima música
func play_music():
	play()
	



# Função para quando acaba o timer
func _on_Timer_timeout():
	play_music()

func _on_finished() -> void:
	var delay = randi() % 20 + 1
	timer.wait_time = delay
	timer.start()
