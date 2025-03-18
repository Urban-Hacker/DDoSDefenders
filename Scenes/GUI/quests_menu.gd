extends Control

var _current_quest:Quest

func _ready():
	$StartMission.hide()
	$Terminal.clear_buffer()
	_load_quests("res://Scenes/Levels/probation_period_quests/probation_period_quests.tscn")


func _load_quests(path:String) -> void:
	var scene = preload("res://Scenes/GUI/quest_button.tscn")
	var quests_scene = load(path)
	var quests_data = quests_scene.instantiate()
	var quests = quests_data.get_quests()
	#var ttt = Label.new()
	#ttt.text = title
	#$ScrollContainer/VBoxContainer.add_child(ttt)
	
	for quest in quests:
		var btn = scene.instantiate()
		btn.set_quest(quest)
		btn.get_button().connect("pressed", _on_load_quest_description.bind(btn))
		$ScrollContainer/VBoxContainer.add_child(btn)

func _on_load_quest_description(btn):
	print("---")
	$Terminal.clear_buffer()
	_current_quest = btn.get_quest()
	#$Terminal.load_file("res://ASCIIArt/logo_mail.txt")
	$Terminal.add_lines(_current_quest.get_mail())
	$Terminal.add_line("\n")
	$StartMission.show()


func _on_start_mission_pressed() -> void:
	_current_quest.launch()
