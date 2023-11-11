extends MarginContainer

@onready var _add_server_dialog_res: Resource = preload("res://client/add_server_dialog.tscn")
@onready var _server_entry_res: Resource = preload("res://client/server_entry.tscn")

@onready var _server_list: VBoxContainer = $VC/SC/ServerList


func add_server(server_ip: String) -> void:
	var entry: Control = _server_entry_res.instantiate()
	entry.setup(server_ip)
	_server_list.add_child(entry)


func _on_add_server_pressed() -> void:
	_open_add_server_dialog()


func _open_add_server_dialog() -> void:
	var dialog: Control = _add_server_dialog_res.instantiate()
	dialog.set_menu_reference(self)
	get_tree().get_root().add_child(dialog)
