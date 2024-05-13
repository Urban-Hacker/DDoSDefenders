@tool

extends Control

@export var _title:String


func _ready():
	$Background.set_size(size)
	$Header.set_size(Vector2(size.x, $Header.size.y))
	$CloseButton.set_position(Vector2($Header.size.x - $CloseButton.size.y, $CloseButton.position.y))

func _process(delta):
	pass


func _on_close_button_pressed():
	Core.on_escape.emit()
