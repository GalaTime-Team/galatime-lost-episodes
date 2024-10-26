extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func options():
	$Settings.visible = true

func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	resume()
	options()

func _on_leave_pressed() -> void:
	get_tree().quit()

func _process(delta: float):
	testEsc()
