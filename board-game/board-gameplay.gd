class_name GlobalGameplay
extends Control

var pending_card := -1
var card_list := {}

func select_cell(pos:int) -> void:
	if pending_card > 0:
		pass
