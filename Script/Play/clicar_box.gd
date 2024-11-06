extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_gui_input(event: InputEvent, arg_timeline: String) -> void:
	if event.is_action_pressed("info") and event.is_pressed():
		Dialogic.start(arg_timeline)
