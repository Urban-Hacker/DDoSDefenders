extends Path2D

@export var _wait_time:float = 1.0

var timer:Timer

func _ready():
	timer = Timer.new()
	timer.timeout.connect(_on_timeout)
	timer.wait_time = _wait_time
	
	timer.autostart = true
	add_child(timer)

func _on_timeout():
	if randi_range(0, 100) < _probability_of_spawn:
		_create_packet()

func _create_packet():
	var scene = preload("res://Scenes/GUI/packet.tscn")
	var packet = scene.instantiate()
	add_child(packet)

