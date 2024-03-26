extends Node

@export var _quantity_of_ennemies:int = 10
@export var _cooldown_between_spawn:float = 1.0
@export var _cooldown_before_next_wave:float = 2.0
@export var _average_ennemies_speed:float = 1.0

func _ready():
	assert (name.begins_with("Wave") == true)

func get_quantity_remaining() -> int:
	return _quantity_of_ennemies

func enemy_created() -> void:
	assert (_quantity_of_ennemies > 0)
	_quantity_of_ennemies-=1;

func get_cooldown() -> float:
	return _cooldown_between_spawn

func get_cooldown_before_next_wave() -> float:
	return _cooldown_before_next_wave

func get_average_ennemies_speed() -> float:
	return _average_ennemies_speed
