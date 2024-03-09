extends Node2D

@export var _connector_left:bool = false
@export var _connector_up:bool = false
@export var _connector_right:bool = false
@export var _connector_down:bool = false

@export var _type:Enum.ChipTypes
var _current_type:Enum.ChipTypes

var _level:int
var _collision_candidates:Dictionary
var _is_cooling_down:bool

func _ready():
	_is_cooling_down = false
	_collision_candidates = {}
	_set_new_type()

func _process(delta):
	if _type == Enum.ChipTypes.empty:
		$Types/CooldownDebug.visible = false
	else:
		$Types/CooldownDebug.visible = _is_cooling_down

func _set_new_type():
	_current_type = _type
	
	$Types/Empty.hide()
	$Types/Subtractor.hide()
	$Types/ShiftRight.hide()
	$Types/Memory.hide()
	$Types/Accumulator.hide()
	$Cooldown.wait_time = 1.0
	_reset_gui()
	
	if _current_type == Enum.ChipTypes.empty:
		$Halo.hide()
		$Types/Empty.show()
		_level = 0
	else:
		_level = 1
		$Halo.show()
	
	if _current_type == Enum.ChipTypes.subtractor:
		$Types/Subtractor.show()
		$Cooldown.wait_time = $Prices.get_cooldown_time(Enum.ChipTypes.subtractor)
	
	if _current_type == Enum.ChipTypes.shift_right:
		$Types/ShiftRight.show()
		$Cooldown.wait_time = $Prices.get_cooldown_time(Enum.ChipTypes.shift_right)
	
	if _current_type == Enum.ChipTypes.memory:
		$Types/Memory.show()
	
	if _current_type == Enum.ChipTypes.accumulator:
		$Types/Accumulator.show()
	
	_render_levels()
	_render_connectors()

func _render_connectors():
	$Connectors/Left.visible = _connector_left
	$Connectors/Up.visible = _connector_up
	$Connectors/Right.visible = _connector_right
	$Connectors/Down.visible = _connector_down

func _render_levels():
	$Levels/l1.hide()
	$Levels/l2.hide()
	$Levels/l3.hide()
	$Levels/l4.hide()
	
	if _level >= 1:
		$Levels/l1.show()
	if _level >= 2:
		$Levels/l2.show()
	if _level >= 3:
		$Levels/l3.show()
	if _level >= 4:
		$Levels/l4.show()

func _reset_gui():
	get_tree().call_group("sockets", "enable")
	$GUI.hide()
	$GUI/Build.hide()
	$GUI/Upgrade.hide()
	$GUI/BackgroundDark.show()

func _render_prices():
	
	# Upgrade / Destroy Menu
	$GUI/Upgrade/DestroyButton.text = "Destroy " + str($Prices.get_destruction_value(_current_type, _level)) + "$"
	$GUI/Upgrade/UpgradeButton.text = "Upgrade " + str($Prices.get_price(_current_type, _level + 1)) + "$"
	
	$GUI/Upgrade/UpgradeButton.disabled = false
	if Core.get_sats_balance() < $Prices.get_price(Enum.ChipTypes.subtractor, _level + 1):
		$GUI/Upgrade/UpgradeButton.disabled = true
	
	# Build Menu
	$GUI/Build/SubtractorButton.text = "Sub " + str($Prices.get_price(Enum.ChipTypes.subtractor, 1)) + "$"
	$GUI/Build/ShiftRightButton.text = "Shf " + str($Prices.get_price(Enum.ChipTypes.shift_right, 1)) + "$"
	$GUI/Build/MemButton.text = "Mem " + str($Prices.get_price(Enum.ChipTypes.memory, 1)) + "$"
	$GUI/Build/AccumulatorButton.text = "Acc " + str($Prices.get_price(Enum.ChipTypes.accumulator, 1)) + "$"
	
	$GUI/Build/SubtractorButton.disabled = false
	$GUI/Build/ShiftRightButton.disabled = false
	$GUI/Build/MemButton.disabled = false
	$GUI/Build/AccumulatorButton.disabled = false
	
	if Core.get_sats_balance() < $Prices.get_price(Enum.ChipTypes.subtractor, 1):
		$GUI/Build/SubtractorButton.disabled = true

	if Core.get_sats_balance() < $Prices.get_price(Enum.ChipTypes.shift_right, 1):
		$GUI/Build/ShiftRightButton.disabled = true

	if Core.get_sats_balance() < $Prices.get_price(Enum.ChipTypes.memory, 1):
		$GUI/Build/MemButton.disabled = true

	if Core.get_sats_balance() < $Prices.get_price(Enum.ChipTypes.accumulator, 1):
		$GUI/Build/AccumulatorButton.disabled = true



func _on_socket_button_pressed():
	_render_prices()
	get_tree().call_group("sockets", "disable")
	$GUI.show()
	if _current_type == Enum.ChipTypes.empty:
		$GUI/Build.show()
	else:
		$GUI/Upgrade.show()


func _on_escape_button_down():
	get_tree().call_group("sockets", "enable")
	_reset_gui()

func _attack():
	if _is_cooling_down:
		print("cooling down")
		return
	
	if !_collision_candidates.is_empty():
		$Cooldown.start()
		_is_cooling_down = true
		var keys = _collision_candidates.keys()
		var candidate = keys[randi_range(0, len(keys) - 1)]
		
		if _current_type == Enum.ChipTypes.subtractor:
			_collision_candidates[candidate].getting_attacked_by_subtractor(_level)
	
		if _current_type == Enum.ChipTypes.shift_right:
			_collision_candidates[candidate].getting_attacked_by_shift_right(_level)
			
		if _current_type == Enum.ChipTypes.memory:
			pass
			#_collision_candidates[candidate].getting_attacked_by_subtractor(_level)
		
		if _current_type == Enum.ChipTypes.accumulator:
			pass
			#_collision_candidates[candidate].getting_attacked_by_subtractor(_level)
		

# We do this enable / disable trick because $GUI Z order is not affecting input order
func disable() -> void:
	$SocketButton.hide()
func enable() -> void:
	$SocketButton.show()

func _set_type(type:Enum.ChipTypes):
	Core.record_transaction(-$Prices.get_price(type, 1))
	_type = type
	_set_new_type()
	_render_levels()
	_reset_gui()

func _on_upgrade_button_pressed():
	if Core.record_transaction(-$Prices.get_price(_current_type, _level + 1)):
		_level += 1
	_render_levels()
	_reset_gui()


func _on_subtractor_button_pressed():
	_set_type(Enum.ChipTypes.subtractor)

func _on_shift_right_button_pressed():
	_set_type(Enum.ChipTypes.shift_right)

func _on_accumulator_button_pressed():
	_set_type(Enum.ChipTypes.accumulator)

func _on_mem_button_pressed():
	_set_type(Enum.ChipTypes.memory)

func _on_destroy_button_pressed():
	Core.record_transaction($Prices.get_destruction_value(_current_type, _level))
	_type = Enum.ChipTypes.empty
	_set_new_type()
	_render_levels()
	_reset_gui()


func _on_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if (area != null):
		if (area.get_meta("is_enemy_area")):
			var node_in_range = area.get_parent()
			node_in_range.is_in_range(true)
			var instance_id = node_in_range.get_instance_id()
			_collision_candidates[instance_id] = node_in_range

	if len(_collision_candidates):
		_attack()

func _on_range_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if (area != null):
		if (area.get_meta("is_enemy_area")):
			var node_in_range = area.get_parent()
			node_in_range.is_in_range(false)
			var instance_id = node_in_range.get_instance_id()
			_collision_candidates.erase(instance_id)


func _on_cooldown_timeout():
	_is_cooling_down = false
	_attack()
