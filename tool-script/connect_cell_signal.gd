@tool
extends Node

@export var connect2node : NodePath :
	set(value) :
		connect2node = value
		global_gameplay = get_node(value)

var global_gameplay : GlobalGameplay

@export var connect_signal := false :
	set(value) :
		if not value:
			return
			
		var i := 0
		for child in get_children():
			child.connect("pressed", Callable(global_gameplay,"select_cell").bind(i),2)
			i += 1

@export var disconnect := false :
	set(value) :
		if not value:
			return
		for child in get_children():
			child.disconnect("pressed", Callable(global_gameplay,"select_cell"))
