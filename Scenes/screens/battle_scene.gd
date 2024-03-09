extends Node2D


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_create_enemies_timeout():
	var scene = preload("res://Scenes/GUI/packet.tscn")
	var node = scene.instantiate()
	if randi_range(0, 10) > 8:
		$Paths/Path2D.add_child(node)
	else:
		$Paths/Path2D2.add_child(node)
