extends AudioStreamPlayer

@export var timer: Timer 
var is_music_allowed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	self.finished.connect(_on_finished)

# Fução para dar play na música com delay aleatório
func play_music():
	if is_music_allowed:
		play()

# Função para quando acaba o timer
func _on_Timer_timeout():
	if is_music_allowed:
		play_music()

func _on_finished() -> void:
	if is_music_allowed:
		var delay = randi() % 20 + 1
		timer.wait_time = delay
		timer.start()
