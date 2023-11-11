extends ColorRect

var _menu: Control

@onready var _label_server_ip: LineEdit = $CC/PC/VC/ServerIP


func set_menu_reference(menu: Control) -> void:
	_menu = menu


func _ready() -> void:
	_label_server_ip.grab_focus()


func _on_add_server_pressed() -> void:
	_add_server(_label_server_ip.get_text())


func _on_server_ip_text_submitted(text: String) -> void:
	_add_server(text)


func _add_server(server_ip: String) -> void:
	_menu.add_server(server_ip)
	queue_free()
