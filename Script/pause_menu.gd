extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume():
	$PanelContainer.visible = true
	$PanelContainer.modulate.a = 1.0
	
	var tween = self.create_tween()
	$AnimationPlayer.play_backwards("blur")
	tween.tween_property($PanelContainer, "modulate:a", 0.0 ,0.2)
	await tween.finished
	
	$PanelContainer.visible = false

func paused():
	$PanelContainer.visible = true
	$PanelContainer.modulate.a = 0.0
	
	var tween = self.create_tween()
	$AnimationPlayer.play("blur")
	tween.tween_property($PanelContainer, "modulate:a", 1.0 ,0.2)
	await tween.finished

func options():
	$Settings.visible = true
	$PanelContainer/Pause_Options_Container.visible = false

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options()

func _on_leave_pressed() -> void:
	get_tree().quit()

func _on_texture_button_pressed() -> void:
	if $PanelContainer.visible == false:
		paused()
	elif $PanelContainer.visible == true:
		resume()

func testEsc():
	if Input.is_action_just_pressed("escape") and $PanelContainer.visible == false:
		paused()
	elif Input.is_action_just_pressed("escape") and $PanelContainer.visible == true:
		resume()

func _process(delta: float):
	testEsc()
