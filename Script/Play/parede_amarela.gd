extends Control

#########
# READY/PROCESS
#########

@export var item : Button

signal item_pressed

func _ready() -> void:
	pass


func _on_item_pressed() -> void:
	item_pressed.emit()
	item.hide()
	set_process(false)
