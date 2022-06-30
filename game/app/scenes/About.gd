tool
extends ScrollContainer

export(String) var title_key := "# "
# This is the About text. To add a Title use the title key
export(String, MULTILINE) var text := "" setget set_text
export(Font) var title_font: Font

onready var _label := $MC/RichTextLabel


func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		set_process(true)


func set_text(val: String):
	text = val
	set_process(true)


# _write_to_label() will fail if the node is outside the tree
# to prevent this it checks every frame if it can update the text and stops the check if it can
func _process(_delta):
	if is_inside_tree():
		_write_to_label()
		set_process(false)


func _write_to_label():
	# Fails when weird stuff happens with scene transitions. Don't ask me why.
	# Also fails in editor sometimes. 
	# It can be savely ignored because it is called more than once!
	if !is_instance_valid(_label):
		return

	_label.clear()
	for line in text.split("\n"):
		var is_title: bool = line.begins_with(title_key)
		line = line.trim_prefix(title_key)
		if is_title:
			_label.push_font(title_font)
		var first := true

		for key in line.split(" "):
			if key.match("[/*]"):
				_label.pop()
			else:
				if first:
					_label.append_bbcode(tr(key))
				else:
					_label.append_bbcode(" " + tr(key))
			first = false
		if is_title:
			_label.pop()
		_label.newline()


func get_line_absolute_height(line: String):
	var pos: float = 0
	var lines: Array = text.split("\n")
	var font_height: int = _label.get_font("normal_font").get_height()

	var line_location := text.find(line)
	# count won't work if location is 0. If it is the height is also 0
	if line_location == 0:
		return 0

	for i in text.count("\n", 0, line_location):
		# i is the line to add the size of
		if lines[i].begins_with(title_key):
			pos += title_font.get_height()
		else:
			pos += font_height
	return pos


func _write_def():
	call_deferred("_write_to_label")


func _on_RichTextLabel_meta_clicked(meta):
	Utils.open_url(meta)
