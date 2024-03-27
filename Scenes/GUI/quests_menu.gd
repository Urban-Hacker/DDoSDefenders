extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
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
		$ScrollContainer/VBoxContainer.add_child(btn)
