extends Node

@export var _probability_of_spawn:int = 50
@export var _minimal_cooldown_between_spawn:float = 1.0

@export_group("Wave Probabilities")
@export var _high_attacker_level:int = 0
@export var _medium_attacker_level:int = 0
@export var _low_attacker_level:int = 0

func _ready():
	assert (name.begins_with("Wave") == true)
