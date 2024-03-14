extends Node

@export var _quantity_of_ennemies:int = 10
@export var _cooldown_between_spawn:float = 1.0

#@export_group("Wave Probabilities")
#@export var _high_attacker_level:int = 0
#@export var _medium_attacker_level:int = 0
#@export var _low_attacker_level:int = 0

func _ready():
	assert (name.begins_with("Wave") == true)

func get_quantity_remaining() -> int:
	return _quantity_of_ennemies
