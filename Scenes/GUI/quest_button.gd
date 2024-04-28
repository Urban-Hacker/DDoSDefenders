extends Control

var _quest:Quest

func set_quest(quest) -> void:
	_quest = quest
	$Button/Label.text = _quest.quest_name

func get_quest() -> Quest:
	return _quest

func get_button() -> Button:
	return $Button
