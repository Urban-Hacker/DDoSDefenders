extends Node2D

@export var _level_name:String
@export var _author:String
@export var _official_level:bool
@export var _waves:int

func _ready():
	_self_tests()
	$PostProcessing.show()


func _process(delta):
	pass

func _self_tests():
	assert(get_node("Ambiance") != null)
	assert(get_node("Background") != null)
	assert(get_node("Wires") != null)
	assert(get_node("Sockets") != null)
	assert(get_node("Paths") != null)
	assert(get_node("PostProcessing") != null)
	assert($PostProcessing.z_index == 1000)
	assert($PostProcessing.z_as_relative == false)
