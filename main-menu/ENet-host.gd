extends Node

var enet_server : ENetMultiplayerPeer

@onready var port_input := $address/port
var port := 72727

func _on_host_pressed():
	enet_server = ENetMultiplayerPeer.new()
	if port_input.text.is_empty:
		
