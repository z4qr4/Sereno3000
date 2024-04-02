extends KinematicBody
class_name HumanNPC

export(Resource) var npc_blueprint

export var selected_material: ShaderMaterial
export var target_color = Color(1,1,1,1)
export var target_outline = 0.02

var is_selected = false

func _ready():
	initialize()

func set_selected(value: bool, color_override: Color = target_color, outline_override: float = target_outline):
		is_selected = true
		if value and selected_material != null:
			selected_material.set_shader_param("outline_thickness", outline_override)
			selected_material.set_shader_param("color", color_override)
			for i in $Skeleton.get_children():
				if i is MeshInstance:
					i.set_material_overlay(selected_material)
		else:
			is_selected = false
			for i in $Skeleton.get_children():
				if i is MeshInstance:
					i.set_material_overlay(null)

func initialize(blueprint: Resource = load("res://Asset Production/Placeholders/NPCs/AverageWhiteMale.tres")):
	npc_blueprint = blueprint
	var npc_skeleton = load(blueprint.skeleton)
	var skeleton = npc_skeleton.instance()
	for i in blueprint.mesh_components:
		var mesh = MeshInstance.new()
		mesh.mesh = (i)
		skeleton.add_child(mesh)
	skeleton.name = "Skeleton"
	add_child(skeleton)

