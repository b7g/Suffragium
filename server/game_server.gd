extends Node

const PORT: int = 9843
const MAX_CLIENTS: int = 32
const VERSION: String = "0.1"

var _server_name: String = "Local dev server"
var _player_count: int = 0


func _ready() -> void:
	var peer := ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.set_multiplayer_peer(peer)
	multiplayer.peer_connected.connect(_client_connected)
	multiplayer.peer_disconnected.connect(_client_disconnected)


func _client_connected(cid: int) -> void:
	print("client connected (id: %s)" % cid)
	_player_count += 1
	_send_server_info(cid)


func _client_disconnected(cid: int) -> void:
	print("client disconnected (id: %s)" % cid)
	_player_count -= 1


func _send_server_info(cid: int) -> void:
	var server_info: Dictionary = {
		"name": _server_name,
		"version": VERSION,
		"p_count": _player_count,
		"p_max": MAX_CLIENTS
	}
	_receive_server_info.rpc_id(cid, server_info)


@rpc("any_peer")
func _receive_server_info(server_info: Dictionary) -> void:
	pass
