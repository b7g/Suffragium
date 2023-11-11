extends PanelContainer

var _ip: String

@onready var _label_ip: Label = $MC/HC/VC/LabelIP


func setup(ip: String) -> void:
	_ip = ip


func _ready() -> void:
	_label_ip.set_text(_ip)


func _on_button_connect_pressed() -> void:
	GameServer.connect_to_server(_ip)


func _on_button_delete_pressed() -> void:
	queue_free()
