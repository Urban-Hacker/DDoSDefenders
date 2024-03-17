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
		content = markdown_to_bbcode(content)
	var lines = content.split("\n")
	for line in lines:
		add_line(line + "\n")

func markdown_to_bbcode(markdown: String) -> String:
	var bbcode = ""
	var lines = markdown.split("\n")
	var in_list = false

	for line in lines:
		if line.strip_edges().begins_with("# "):
			bbcode += "" + line.replace("\n", "") + "\n" + "=".repeat(len(line)) + "\n"
			continue
		if line.strip_edges().begins_with("* "):
			if not in_list:
				bbcode += "[ul]"
				in_list = true
			bbcode += line.replace("* ", "") + "\n"
		else:
			if in_list:
				bbcode += "[/ul]\n"
				bbcode = bbcode.replace("\n[/ul]", "[/ul]")
				in_list = false
			bbcode += line + "\n"

	if in_list:
		bbcode += "[/ul]\n"

	return bbcode.strip_edges()

func clear_buffer() -> void:
	_buffer.clear()
	text = ""
