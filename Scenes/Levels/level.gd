extends Node2D

@export var _level_name:String
@export var _author:String
@export var _official_level:bool
@export var _waves:int

var _enemy_creator:Timer
var _current_wave:int

func _init():
	Core.current_level = self

func _ready():
	_self_tests()
	$PostProcessing.show()
	
	_current_wave = 1
	_enemy_creator = Timer.new()
	
	_enemy_creator.timeout.connect(_on_enemy_creator_timeout)
	_enemy_creator.wait_time = 0.5
	_enemy_creator.autostart = true
	add_child(_enemy_creator)

func _on_enemy_creator_timeout():
	var wave = get_node("Waves/Wave" + str(_current_wave))
	if wave.get_quantity_remaining() > 0:
		var spawn = get_spawn_point()
		spawn.create_packet()

func _self_tests():
	assert(get_node("Ambiance") != null)
	assert(get_node("Waves") != null)
	assert(get_node("Background") != null)
	assert(get_node("Wires") != null)
	assert(get_node("Sockets") != null)
	assert(get_node("Paths") != null)
	assert(get_node("PostProcessing") != null)
	assert($PostProcessing.z_index == 1000)
	assert($PostProcessing.z_as_relative == false)

	assert(len($Waves.get_children()) == _waves)

func get_spawn_point() -> Node:
	var spawn_candidates = $Paths.get_children()
	var spawns = []
	for spawn in spawn_candidates:
		if spawn.is_active_for_wave(_current_wave):
			spawns.append(spawn)
	var spawn = spawns[randi_range(0, len(spawns) - 1)]
	return spawn

func get_waves() -> int:
	return _waves
