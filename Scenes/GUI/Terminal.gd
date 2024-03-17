extends RichTextLabel

var _buffer:Array[String]

func _ready():
	clear_buffer()


func _on_bauds_timeout():
	if len(_buffer) > 0:
		var line = _buffer.pop_front()
		text += line

func add_line(input:String) -> void:
	_buffer.append(input)

func load_file(path:String, parse_markdown=false) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	if parse_markdown:
		content = Core.markdown_to_bbcode(content)
	var lines = content.split("\n")
	for line in lines:
		add_line(line + "\n")

func clear_buffer() -> void:
	_buffer.clear()
	text = ""
