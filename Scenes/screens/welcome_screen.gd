extends Node2D

var _version_main:int
var _version_patch:int

func _ready():
	_version_main = ProjectSettings.get("application/config/version_main")
	_version_patch =  ProjectSettings.get("application/config/version_patch")
	$GUI/Version.text = "Ver: " + str(_version_main) + "." + str(_version_patch)


func _process(delta):
	pass
