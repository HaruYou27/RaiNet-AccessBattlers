extends WebRTCui

func _on_host_pressed() -> void:
	print_debug("_on_host_pressed() shouldn't be called on joinWebRtc")

func _on_reply_offer_text_changed() -> void:
	setup(false)
	label.text = "Processing..."
	
	super()

func _peer_disconnected(_id: int) -> void:
	label.text = "Disonnected."
	button.hide()
