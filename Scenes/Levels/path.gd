extends Path2D

@export var _active_waves:Array[bool] = [true]

func _ready():
	assert(len(_active_waves) == Core.current_level.get_waves())

func is_active_for_wave(current_wave:int) -> bool:
	return _active_waves[current_wave - 1]

func create_packet(wave) -> void:
	var scene = preload("res://Scenes/GUI/packet.tscn")
	var packet = scene.instantiate()
	packet.set_wave(wave)
	add_child(packet)
