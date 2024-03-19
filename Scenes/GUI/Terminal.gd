extends RichTextLabel

var _buffer:Array[_Line]

func _ready():
	clear_buffer()

func _on_bauds_timeout():
	var rate = 0.1
	if len(_buffer) > 0:
		var line = _buffer.pop_front()
		text += line.text
		rate = line.rate
	$Bauds.stop()
	print(rate)
	$Bauds.start(rate)

func add_progress_bar(input:String) -> void:
	add_line(input + " ", 0.05)
	for i in range(0, 10):
		add_line(".", 0.05)
	add_line(" [DONE]\n", 0.05)
		

func add_line(input:String, rate:float=0.1) -> void:
	var line = _Line.new(input, rate)
	_buffer.append(line)

func load_file(path:String, parse_markdown=false) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	if parse_markdown:
		content = Core.markdown_to_bbcode(content)
	var lines = content.split("\n")
	for line in lines:
		add_line(line + "\n", 0.1)

func clear_buffer() -> void:
	_buffer.clear()
	text = ""

class _Line:
	var rate:float
	var text:String
	
	func _init(init_text, init_rate):
		rate = init_rate
		text = init_text
