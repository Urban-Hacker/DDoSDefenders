extends Control

@export var _quest:Quest

# Called when the node enters the scene tree for the first time.
func _ready():
	_create_quests("Probation Period", 3)


func _process(delta):
	pass


func _create_quests(title:String, amount:int) -> void:
	#var ttt = Label.new()
	#ttt.text = title
	#$ScrollContainer/VBoxContainer.add_child(ttt)
	
	for i in range(0, amount):
		
		var scene = preload("res://Scenes/GUI/quest_button.tscn")
		var btn = scene.instantiate()
		btn.set_quest(_quest)
		$ScrollContainer/VBoxContainer.add_child(btn)
