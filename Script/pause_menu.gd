extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $PanelContainer
@onready var pause_menu_container: VBoxContainer = $PanelContainer/Pause_Menu_Container
@onready var options_container: VBoxContainer = $PanelContainer/Options_Container
@onready var back: Button = $PanelContainer/Back

#####
# AUX
#####

func initial_values():
	panel_container.visible = false
	panel_container.modulate.a = 0.0
	
	options_container.visible = false
	options_container.modulate.a = 0.0
	
	back.modulate.a = 0.0
	
	pause_menu_container.visible = true
	pause_menu_container.modulate.a = 1.0

func _ready() -> void:

	initial_values()
	
	animation_player.play("RESET")

func resume():
	panel_container.visible = true
	panel_container.modulate.a = 1.0
	
	var tween = self.create_tween()
	animation_player.play_backwards("blur")
	tween.tween_property(panel_container, "modulate:a", 0.0 ,0.2)
	await tween.finished
	
	panel_container.visible = false

func paused():
	initial_values()
	
	panel_container.visible = true
	
	var tween = self.create_tween()
	animation_player.play("blur")
	tween.tween_property(panel_container, "modulate:a", 1.0 ,0.2)
	await tween.finished

func options():
	pause_menu_container.visible = true
	
	options_container.visible = false
	options_container.modulate.a = 0.0
	
	back.modulate.a = 0.0
	
	var tween = self.create_tween()
	tween.tween_property(pause_menu_container, "modulate:a", 0.0 ,0.2)
	
	pause_menu_container.visible = false
	options_container.visible = true
	back.visible = true
	
	tween.tween_property(options_container, "modulate:a", 1.0 ,0.2)
	tween.tween_property(back, "modulate:a", 1.0 ,0.2)
	await tween.finished
	tween.stop()

#####
# Buttons Interactions
#####

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options()

func _on_leave_pressed() -> void:
	get_tree().quit()

func _on_texture_button_pressed() -> void:
	if panel_container.visible == false:
		paused()
	elif panel_container.visible == true:
		resume()

func testEsc():
	if Input.is_action_just_pressed("escape") and panel_container.visible == false:
		paused()
	elif Input.is_action_just_pressed("escape") and panel_container.visible == true:
		resume()

func _process(_delta: float):
	testEsc()


func _on_back_pressed() -> void:	
	var tween = self.create_tween()
	tween.tween_property(options_container, "modulate:a", 0.0 ,0.2)
	tween.tween_property(back, "modulate:a", 0.0 ,0.2)
	
	pause_menu_container.visible = true
	options_container.visible = false
	back.visible = false
	
	tween.tween_property(pause_menu_container, "modulate:a", 1.0 ,0.2)
	await tween.finished
	tween.stop()
