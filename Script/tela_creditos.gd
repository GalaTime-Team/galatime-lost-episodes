class_name TelaCreditos
extends Control

signal back_credits_menu 
@onready var back  =  $MarginContainer/Back as Button
@onready var b_credits_click  = $b_credits_click as AudioStreamPlayer


func _ready():
	back.button_down.connect(on_back_pressed)
	set_process(false)

func on_back_pressed()->void:
	back_credits_menu.emit()
	b_credits_click.play()
	set_process(false)
	
