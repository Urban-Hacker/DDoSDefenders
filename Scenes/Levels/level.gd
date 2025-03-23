extends Node2D

@export var _level_name:String
@export var _author:String
@export var _official_level:bool
@export var _waves:int = 1
@export var _allow_upgrades:bool = true
@export var _allow_destruction:bool = true

@export var _allow_sub:bool = true
@export var _allow_shift:bool = true
@export var _allow_memory:bool = true
@export var _allow_accumulator:bool = true

var _enemy_creator:Timer
var _switch_to_next_wave:Timer
var _current_wave:int
var _cpu_total_lives:int = 3
var _cpu_lives:int = 3
var _winning_cool_down:int = 1

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
	_enemy_creator.one_shot = true
	add_child(_enemy_creator)
	
	_switch_to_next_wave = Timer.new()
	_switch_to_next_wave.timeout.connect(_on_switch_to_next_wave_timeout)
	_switch_to_next_wave.autostart = false
	_switch_to_next_wave.one_shot = true
	add_child(_switch_to_next_wave)
	
	get_tree().call_group("sockets", "allow_upgrades", _allow_upgrades)
	get_tree().call_group("sockets", "allow_destruction", _allow_destruction)
	get_tree().call_group("sockets", "enable_chips", _allow_sub, _allow_shift, _allow_memory, _allow_accumulator)

	$BattleGUI.set_title(_level_name)
	refresh()

func _on_enemy_creator_timeout():
	var wave = get_node("Waves/Wave" + str(_current_wave))
	if wave.get_quantity_remaining() > 0:
		var spawn = get_spawn_point()
		spawn.create_packet(wave)
		wave.enemy_created()
	else:
		if _current_wave != _waves:
			_switch_to_next_wave.start(wave.get_cooldown_before_next_wave())
		else:
			if get_tree().get_nodes_in_group("packets").size() == 0 and _cpu_lives > 0:
				_winning_cool_down -= 1
				if _winning_cool_down <= 0:
					_turn_off_lights()
					$BattleGUI/PopupWin.show()
	_enemy_creator.stop()
	_enemy_creator.start(wave.get_cooldown())

func _on_switch_to_next_wave_timeout():
	print("next wave")
	_switch_to_next_wave.stop()
	_current_wave += 1

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

func _turn_off_lights() -> void:
	get_tree().call_group("sockets", "hide")
	get_tree().call_group("targets", "hide")

func hit_cpu() -> void:
	_cpu_lives -= 1
	if (_cpu_lives <= 0):
		_turn_off_lights()
		$BattleGUI/PopupLost.show()
	refresh()

func refresh() -> void:
	$BattleGUI.update_lives(str(_cpu_lives) + "/" + str(_cpu_total_lives) + " CPU")
	

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
