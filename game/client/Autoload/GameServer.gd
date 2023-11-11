extends Node

const PORT: int = 9843


func connect_to_server(ip: String) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, PORT)
	multiplayer.set_multiplayer_peer(peer)
	multiplayer.connected_to_server.connect(_connected)
	multiplayer.connection_failed.connect(_no_connection)
	multiplayer.server_disconnected.connect(_disconnected)


func _connected() -> void:
	print("GS: Connection established")


func _no_connection() -> void:
	print("GS: Could not connect")


func _disconnected() -> void:
	print("GS: Connection lost")


@rpc
func _receive_server_info(server_info: Dictionary) -> void:
	print("Server: '", server_info["name"],
	"', version: ", server_info["version"],
	", players: ", server_info["p_count"],
	"/", server_info["p_max"])
