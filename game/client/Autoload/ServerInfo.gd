extends Node

const INFO_PATH: String = "user://server_info.json"

var _server_info: Dictionary


func _ready() -> void:
	_load_from_storage()


func _load_from_storage() -> void:
	var file = FileAccess.open(INFO_PATH, FileAccess.READ)
	if not file:
		return
	_server_info = JSON.parse_string(file.get_line())


func _save_to_storage() -> void:
	var as_json: String = JSON.stringify(_server_info)
	var file = FileAccess.open(INFO_PATH, FileAccess.WRITE)
	if not file:
		return
	file.store_line(as_json)
