extends KinematicBody

export(Color) var target_color = Color(1,1,1,1)
export(float) var target_outline = 0.01
export(ShaderMaterial) var selected_material

var skeleton
var is_selected = false

func _ready():
	skeleton = $humanRig

func set_selected(display: bool, outline_color: Color = target_color, outline_thickness: float = target_outline):
	if display:
		selected_material.set_shader_param("outline_thickness", outline_thickness)
		selected_material.set_shader_param("color", outline_color)
		for i in skeleton.get_children():
			if i is MeshInstance:
				i.set_material_overlay(selected_material)
	else:
		is_selected = false
		for i in skeleton.get_children():
			if i is MeshInstance:
				i.set_material_overlay(null)

