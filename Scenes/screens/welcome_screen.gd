extends Node2D

var _version_main:int
var _version_patch:int

func _ready():
	_version_main = ProjectSettings.get("application/config/version_main")
	_version_patch =  ProjectSettings.get("application/config/version_patch")
	$GUI/VersionButton.text = "Ver: " + str(_version_main) + "." + str(_version_patch)


func _process(delta):
	pass


func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/screens/missions.tscn")
