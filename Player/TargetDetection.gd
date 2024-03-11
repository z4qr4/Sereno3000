extends Area

var current_target
var subjects_in_range = []

signal target_selected(target)

func _on_body_entered(body):
	subjects_in_range.append(body)

func _on_body_exited(body):
	subjects_in_range.erase(body)
	body.set_selected(false)

func _process(delta):
	if subjects_in_range.size() > 0:
		var target = get_closest_subject(self.global_translation, subjects_in_range)
		if target != current_target:
			current_target = target
			emit_signal("target_selected", current_target)
	else:
		if current_target != null:
			current_target = null
			emit_signal("target_selected", null)

func get_closest_subject(origin:Vector3, group:Array):
	var closest = null
	var min_dist = 0.0
	for i in group:
		var distance = origin.distance_to(i.global_translation)
		if closest == null or distance < min_dist:
			closest = i
			min_dist = distance
#			Change this line if targets' node structure changes:
#			i.get_parent().set_material_overlay(null)
			i.set_selected(false)
	return closest
