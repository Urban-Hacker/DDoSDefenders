extends Control

func _ready():
	var scene = preload("res://Scenes/GUI/load_changelog_button.tscn")
	
	var files = Core.get_in_folder("res://Changelogs")
	for file in files:
		var btn = scene.instantiate()
		btn.text = "> " + file
		$ScrollContainer/VBoxContainer.add_child(btn)

func render(version_string, changelog_file) -> void:
	$Terminal.clear_buffer()
	$Terminal.load_file("res://ASCIIArt/logo.txt")
	$Terminal.add_line("Current Version: " + version_string + "\n\n")
	$Terminal.load_file("res://Changelogs/" + changelog_file, true)
