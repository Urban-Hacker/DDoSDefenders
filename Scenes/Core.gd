extends Node

signal on_balance_changed

var _sats:int = 200 # sats = satoshi
var current_level:Node


func get_sats_balance() -> int:
	return _sats

func record_transaction(value:int) -> bool:
	if value < 0 and (_sats + value) < 0:
		return false
	_sats += value
	on_balance_changed.emit()
	return true


func int_to_bin_str(value:int, level:int) -> String:
	var binary_str = ""
	while value > 0:
		var bit = value % 2
		binary_str = str(bit) + binary_str
		value = value >> 1
	
	if binary_str == "":
		binary_str = "0"
	if level == 0:
		pass
	if level == 1:
		binary_str = _pad(binary_str, 2)
	if level == 2:
		binary_str = _pad(binary_str, 3)
	return binary_str

func _pad(string_to_pad:String, length:int) -> String:
	var padding = "" 
	for i in range(0, length - len(string_to_pad)):
		padding += "0"
	return padding + string_to_pad
