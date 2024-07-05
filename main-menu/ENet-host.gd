extends Node

var enet_server := ENetMultiplayerPeer.new()

@onready var port_input := $address/port
var port : int

func _on_host_pressed():
	enet_server.close()
	var err := -1
	if port_input.text.is_empty:
		port = 7272
		while err != OK and port < 60000:
			err = enet_server.create_server(port)
			print_debug(err)
	else:
		err = enet_server.create_server(port_input.text.to_int(),1)
		print_debug(err)
