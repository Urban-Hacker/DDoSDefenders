extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GUI.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_mission_button_pressed() -> void:
	$GUI.show()
