extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PopupLost.hide()
	$PopupWin.hide()
	_on_balance_changed()
	Core.on_balance_changed.connect(_on_balance_changed)

func _on_balance_changed():
	$Background/Money.text = str(Core.get_sats_balance()) + "$"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_give_up_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/screens/missions.tscn")
