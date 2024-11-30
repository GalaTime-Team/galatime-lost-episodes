extends Node

func save_game():
	var file = FileAccess.open("user://savegame.txt", FileAccess.WRITE)
	file.store_string(Global.sala_que_estamos)
	file.close()

func load_game():
	var file = FileAccess.open("user://savegame.txt", FileAccess.READ)
	Global.sala_que_estamos = file.get_as_text()
	file.close()
