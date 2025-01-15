extends Button


func _ready() -> void:
	if Global.puzzles["puzzle1"]["completo"]:
		self.visible = true
