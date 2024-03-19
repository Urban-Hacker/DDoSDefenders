extends Control

var _version_string:String

func _ready():
	var scene = preload("res://Scenes/GUI/load_changelog_button.tscn")
	
	var files = Core.get_in_folder("res://Changelogs")
	files.reverse()
	for file in files:
		var btn = scene.instantiate()
		btn.connect("pressed", _on_load_changelog.bind(file))
		btn.text = "> " + file
		$ScrollContainer/VBoxContainer.add_child(btn)

func render(version_string, changelog_file, previous_version=false) -> void:
	_version_string = version_string
	$Terminal.clear_buffer()
	$Terminal.load_file("res://ASCIIArt/logo.txt")
	if previous_version:
		$Terminal.add_line("[color=red]/!\\ Loading information from old version[/color]\n\n")
	else:
		$Terminal.add_line("Current Version: [color=#09d5b7]" + version_string + "[/color]\n\n")
	$Terminal.load_file("res://Changelogs/" + changelog_file, true)

func _on_load_changelog(file_to_load):
	render(_version_string, file_to_load, true)
