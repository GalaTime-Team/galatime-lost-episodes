extends Control

@export var b1 : Button
@export var b2 : Button
@export var b3 : Button

var n1 : int = 0
var n2 : int = 0
var n3 : int = 0

func _ready() -> void:
	if Global.puzzle1_complete:
		b1.text = str(Global.puzzle1_valores[0])
		b2.text = str(Global.puzzle1_valores[1])
		b3.text = str(Global.puzzle1_valores[2])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button1_pressed() -> void:
	if !Global.puzzle1_complete:
		n1 += 1
		if n1 > 9:
			n1 = 0
		b1.text = str(n1)

func _on_button2_pressed() -> void:
	if !Global.puzzle1_complete:
		n2 += 1
		if n2 > 9:
			n2 = 0
		b2.text = str(n2)

func _on_button3_pressed() -> void:
	if !Global.puzzle1_complete:
		n3 += 1
		if n3 > 9:
			n3 = 0
		b3.text = str(n3)
