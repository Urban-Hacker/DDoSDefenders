extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
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
	var quest = btn.get_quest()
	$Terminal.add_progress_bar("Loading Mail")
	$Terminal.add_line("\n")
	$Terminal.add_line("====\n")
	$Terminal.add_line("Date: Saturday 10 April 2017\n")
	$Terminal.add_line("From: alex.spencer@mail.local\n")
	$Terminal.add_line("To:   alice@mail.local\n")
	$Terminal.add_line("====\n")
	$Terminal.add_line("[bgcolor=white][color=green]Subject: " + quest.quest_name + "[/color][/bgcolor]\n")
	$Terminal.add_line("\n")
	$Terminal.add_lines(btn.get_quest().quest_description)
