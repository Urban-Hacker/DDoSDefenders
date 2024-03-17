extends Node2D

enum _STATES {welcome, changelog}

var _version_main:int
var _version_patch:int
var _version_string:String
var _changelog_file:String
var _current_state:_STATES

func _ready():
	_version_main = ProjectSettings.get("application/config/version_main")
	_version_patch =  ProjectSettings.get("application/config/version_patch")
	_version_string = str(_version_main) + "." + str(_version_patch)
	_changelog_file = str(_version_main) + "_" + str(_version_patch) + ".md"
	$GUI/ChangelogButton.text = "> Ver: " + _version_string
	SaveSystem.set_var("slot", 1)
	_change_state(_STATES.welcome)


func _change_state(state:_STATES):
	_current_state = state
	$GUI/Changelog.hide()
	$GUI/Logo.hide()
	
	if _current_state == _STATES.welcome:
		$GUI/Logo.show()
	
	if _current_state == _STATES.changelog:
		$GUI/Changelog/Terminal.clear_buffer()
		$GUI/Changelog/Terminal.load_file("res://Changelogs/logo.txt")
		$GUI/Changelog/Terminal.add_line("Current Version: " + _version_string + "\n\n")
		$GUI/Changelog/Terminal.load_file("res://Changelogs/" + _changelog_file, true)
		$GUI/Changelog.show()

func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/screens/missions.tscn")


func _on_changelog_button_pressed():
	_change_state(_STATES.changelog)
