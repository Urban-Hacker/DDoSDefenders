extends Control

var _quest:Quest

func set_quest(quest) -> void:
	_quest = quest
	$Button.text = _quest.quest_name
	$Button.button_down.connect(_on_button_down) 

func _on_button_down():
	_quest.launch()
