extends Node

var _subtractor:int = 8
var _shift_right:int = 16
var _accumulator:int = 10
var _memory:int = 12
var _clock:int = 32 

var _subtractor_cooldown:float = 0.1
var _shift_right_cooldown:float = 0.5

func get_price(type:Enum.ChipTypes, level:int) -> int:
	var price = 0
	match type:
		Enum.ChipTypes.subtractor:
			price = _subtractor
		Enum.ChipTypes.shift_right:
			price = _shift_right
		Enum.ChipTypes.accumulator:
			price = _accumulator
		Enum.ChipTypes.memory:
			price = _memory
		Enum.ChipTypes.clock:
			price = _clock
	return price * level # TODO, replace this by a better system

func get_destruction_value(type:Enum.ChipTypes, level:int) -> int:
	return int(get_price(type, level) * 0.7)

func get_cooldown_time(type:Enum.ChipTypes) -> float:
	var cooldown = 0
	match type:
		Enum.ChipTypes.subtractor:
			cooldown = _subtractor_cooldown
		Enum.ChipTypes.shift_right:
			cooldown = _shift_right_cooldown
	return cooldown
