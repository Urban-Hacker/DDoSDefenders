extends PathFollow2D

var _speed:float = 1.0
var _socket_reference_counter:int
var _ttl:int
var _level:int

func _ready():
	_level = randi_range(0, 2)
	if _level == 0:
		_ttl = randi_range(0, 1)
	if _level == 1:
		_ttl = randi_range(0, 3)
	if _level == 2:
		_ttl = randi_range(0, 7)
	_socket_reference_counter = 0
	$Range/Debug.hide()
	$Range.hide()
	refresh()

func _process(delta):
	refresh()

func _on_move_timeout():
	progress = progress + _speed

func refresh() -> void:
	$Widget/Label.text = Core.int_to_bin_str(_ttl, _level)

func hit_cpu_and_die() -> void:
	queue_free()

func is_in_range(yes:bool) -> void:
	if yes:
		_socket_reference_counter += 1
		
	else:
		_socket_reference_counter -= 1

	if _socket_reference_counter > 0:
		$Range/Debug.show()
	else:
		$Range/Debug.hide()

func getting_attacked_by_subtractor(level:int) -> void:
	_ttl -= level
	if _ttl < 0:
		queue_free()

func getting_attacked_by_shift_right(level:int) -> void:
	if _ttl > 0:
		_ttl = int(_ttl / pow(2, level))

func getting_attacked_by_memory(level:int) -> void:
	queue_free()

func set_wave(wave) -> void:
	_speed = wave.get_average_ennemies_speed()
