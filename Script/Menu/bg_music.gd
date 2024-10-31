extends AudioStreamPlayer

@export var timer: Timer 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	play_music()
	pass # Replace with function body.



# Fução para dar play na música com delay aleatório
func play_music():
	play()
	

# Função para quando acaba o timer
func _on_Timer_timeout():
	play_music()


func _on_finished() -> void:
	var delay = randi() % 20 + 1  #delay aleatório entre as músicas
	timer.wait_time = delay
	timer.start()
	pass # Replace with function body.
