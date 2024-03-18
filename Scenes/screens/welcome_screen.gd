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
	$GUI/Buttons/ChangelogButton.text = "> Ver: " + _version_string
	SaveSystem.set_var("slot", 1)
	_change_state(_STATES.welcome)


func _change_state(state:_STATES):
	_current_state = state
	$GUI/ChangelogMenu.hide()
	$GUI/Logo.hide()
	$GUI/Buttons.hide()
	$GUI/Escape.hide()
	
	if _current_state == _STATES.welcome:
		$GUI/Logo.show()
		$GUI/Buttons.show()
	
	if _current_state == _STATES.changelog:
		$GUI/ChangelogMenu.render(_version_string, _changelog_file)
		$GUI/ChangelogMenu.show()
		$GUI/Escape.show()


func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/screens/missions.tscn")


func _on_changelog_button_pressed():
	_change_state(_STATES.changelog)


func _on_escape_button_down():
	_change_state(_STATES.welcome)
