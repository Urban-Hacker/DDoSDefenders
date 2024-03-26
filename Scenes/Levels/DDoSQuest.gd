extends Quest
class_name DDoSQuest

@export var _smartContracts:int
@export var _level:PackedScene

func launch() -> void:
	Core.get_tree().change_scene_to_packed(_level)

func start() -> void:
	print("Quest Started")

func complete() -> void:
	print("Quest Completed")

func another_cool_function(quest_id) -> void:
	print(quest_id)
	if quest_id == self.id:
		objective_completed = true
