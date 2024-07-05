extends Node
class_name WebRTCui

var webrtc := WebRTCMultiplayerPeer.new()
var connection := WebRTCPeerConnection.new()

var SDP : String
var ICE : String

@onready var label : Label = $HBoxContainer/Label
@onready var offer : TextEdit = $offer
@onready var ice_timer : Timer = $IceTimer
@onready var reply : TextEdit = $reply
@onready var button : Button = $HBoxContainer/button

func _ice_candidate_created(media:String, index:int, Name:String) -> void:
	ICE += media + "&&&"
	ICE += str(index) + "&&&"
	ICE += Name
	ice_timer.start()

func _session_description_created(type:String, sdp:String) -> void:
	SDP = sdp
	connection.set_local_description(type, sdp)

func _ready() -> void:
	webrtc.peer_connected.connect(_peer_connected)
	webrtc.peer_disconnected.connect(_peer_disconnected)
	connection.ice_candidate_created.connect(_ice_candidate_created)
	connection.session_description_created.connect(_session_description_created)

var sdp_type : String
const IceServer := [ { "urls": ["stun:stun.l.google.com:19302"]}]
func setup(is_host:bool) -> void:
	ICE = ''
	SDP = ''
	connection.initialize({ "iceServers": IceServer})
	
	if is_host:
		webrtc.create_mesh(1)
		webrtc.add_peer(connection, 2)
		sdp_type = 'answer'
	else:
		webrtc.create_mesh(2)
		webrtc.add_peer(connection, 1)
		sdp_type = 'offer'
	
	multiplayer.multiplayer_peer = webrtc

func _on_reply_offer_text_changed() -> void:
	var reply_text : String = (reply.text)
	var reply_text_splited : PackedStringArray = reply_text.split("***", false, 1);
	
	if reply_text_splited.size() != 2:
		label.text = "Offer invaild."
		return
	
	connection.set_remote_description(sdp_type, reply_text_splited[1])
	
	var ice = reply_text_splited[0].split("&&&", false, 2);
	
	if ice.size() != 3:
		label.text = "Offer invaild."
		return
		
	connection.add_ice_candidate(ice[0], ice[1].to_int(), ice[2])

func _on_host_pressed() -> void:
	setup(true)
	button.text = "Cancel"
	connection.create_offer()

func _peer_connected(id: int) -> void:
	print_debug("******* PEER CONNECTED WITH ID %s *******" % str(id))
	label.text = "Connected."
	button.text = "Disband Party"

func _peer_disconnected(_id: int) -> void:
	label.text = "Disonnected."
	button.text = "Host Party"

func _on_disconnect_pressed() -> void:
	webrtc.close()
	label.text = ""

func _on_ice_timer_timeout() -> void:
	offer.text = ICE + "***" + SDP
