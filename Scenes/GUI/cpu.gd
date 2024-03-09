extends Node2D

func _ready():
	$Sprite2D/hit.hide()

func _on_damage_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if (area != null):
		if (area.get_meta("is_enemy_area")):
			area.get_parent().hit_cpu_and_die()
			$Sprite2D/hit.show()
			$AnimationPlayer.play("hit")
