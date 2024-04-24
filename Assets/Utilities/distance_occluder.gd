class_name DistanceOccluder
extends Node

export var render_distance = 30

func _process(delta):
	var actual_distance = get_parent().global_translation.distance_to(get_viewport().get_camera().global_translation)
	if actual_distance > render_distance:
		get_parent().hide()
	else:
		get_parent().show()

