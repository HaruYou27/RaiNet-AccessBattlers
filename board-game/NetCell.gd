extends RefCounted
class_name NetCell

var is_boosted := false

enum Card {NOTHING, LINK_PLAYER, VIRUS_PLAYER, LINK_OPPONENT, VIRUS_OPPONENT, FIREWALL_PLAYER, FIREWALL_OPPONENT, PORT_PLAYER, PORT_OPPONENT}
var contain := 0
