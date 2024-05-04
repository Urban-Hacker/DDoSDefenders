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

func get_mail() -> String:
		#$Terminal.add_line("Date:    Saturday 10 April 2017\n")
	#$Terminal.add_line("From:    alex.spencer@mail.local\n")
	#$Terminal.add_line("To:      " + Core.get_player_name().to_lower() + "@mail.local\n")
	#$Terminal.add_line("\n")
	var mail = "Subject: " + quest_name + "\n"
	mail += "------------------------------\n"
	mail += quest_description.replace("[objectives]", quest_objective)
	return mail
