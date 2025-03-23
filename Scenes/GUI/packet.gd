extends PathFollow2D

var _speed:float = 1.0
var _socket_reference_counter:int
var _ttl:int
var _level:int

func _ready():
	_socket_reference_counter = 0
	$Range/Debug.hide()
	$Range.hide()
	refresh()

func _process(delta):
	refresh()

func _calculate_ttl():
	if _level == 0:
		_ttl = randi_range(0, 1)
	if _level == 1:
		_ttl = randi_range(0, 3)
	if _level == 2:
		_ttl = randi_range(0, 7)

func _on_move_timeout():
	progress = progress + _speed

func _invert_binary() -> void:
	# Get the binary string with leading zeroes, respecting the level
	var binary_str = Core.int_to_bin_str(_ttl, _level)

	# Invert each digit in the binary string
	var inverted_str = ""
	for char in binary_str:
		inverted_str += "1" if char == "0" else "0"  # Correct ternary syntax in GDScript

	# Convert the inverted binary string back to an integer manually
	var new_ttl = 0
	var length = inverted_str.length()
	for i in range(length):
		if inverted_str[i] == "1":
			new_ttl += pow(2, length - i - 1)

	# Update _ttl and refresh the display
	_ttl = new_ttl
	refresh()

func refresh() -> void:
	$Widget/Label.text = Core.int_to_bin_str(_ttl, _level)

func hit_cpu_and_die() -> void:
	Core.current_level.hit_cpu()
	queue_free()

func is_in_range(yes:bool) -> void:
	if yes:
		_socket_reference_counter += 1
		
	else:
		_socket_reference_counter -= 1

	if _socket_reference_counter > 0:
		$Range/Debug.show()
		$ButtonInvert.hide()
	else:
		$Range/Debug.hide()
		$ButtonInvert.show()

func getting_attacked_by_subtractor(level:int) -> void:
	_ttl -= level
	if _ttl < 0:
		Core.record_transaction(_level + 1)
		queue_free()

func getting_attacked_by_shift_right(level:int) -> void:
	if _ttl > 0:
		_ttl = int(_ttl / pow(2, level))

func getting_attacked_by_memory(level:int) -> void:
	queue_free()

func set_wave(wave) -> void:
	_speed = wave.get_average_ennemies_speed()
	_level = wave.get_level()
	_calculate_ttl()


func _on_button_invert_pressed() -> void:
	_invert_binary()
