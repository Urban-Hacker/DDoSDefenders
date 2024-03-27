extends Node


@export var Name:String
@export var DayOneQuest: Quest
@export var DayTwoQuest: Quest

func get_quests() -> Array[Quest]:
	return [DayOneQuest, DayTwoQuest]
