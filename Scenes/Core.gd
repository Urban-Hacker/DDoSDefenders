extends Node

signal on_balance_changed
signal on_escape

var _sats:int = 200 # sats = satoshi
var current_level:Node


func get_sats_balance() -> int:
	return _sats

func record_transaction(value:int) -> bool:
	if value < 0 and (_sats + value) < 0:
		return false
	_sats += value
	on_balance_changed.emit()
	return true


func int_to_bin_str(value:int, level:int) -> String:
	var binary_str = ""
	while value > 0:
		var bit = value % 2
		binary_str = str(bit) + binary_str
		value = value >> 1
	
	if binary_str == "":
		binary_str = "0"
	if level == 0:
		pass
	if level == 1:
		binary_str = _pad(binary_str, 2)
	if level == 2:
		binary_str = _pad(binary_str, 3)
	return binary_str

func _pad(string_to_pad:String, length:int) -> String:
	var padding = "" 
	for i in range(0, length - len(string_to_pad)):
		padding += "0"
	return padding + string_to_pad

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

func get_in_folder(path) -> Array:
	var dir = DirAccess.open(path)
	var files = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				files.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

	files.sort()
	return files
