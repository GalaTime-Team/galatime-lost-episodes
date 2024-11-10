extends Button


func _ready() -> void:
	if Global.puzzle1_complete == true:
		self.visible = true
