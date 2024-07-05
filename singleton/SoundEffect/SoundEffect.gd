extends Node

func _ready() -> void:
	set_process(false)

@onready var tick0 := $tick0
func hover() -> void:
	tick0.play()

@onready var press0 := $press0
@onready var press1 := $press1
func press(pitch:bool) -> void:
	if pitch:
		press1.play()
	else:
		press0.play()
