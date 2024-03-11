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

func initialize(blueprint: Resource = load("res://Assets/NPCs/default_npc.tres")):
	npc_blueprint = blueprint
	$Skeleton/eyes.mesh = npc_blueprint.eyes_mesh
	$Skeleton/skin.mesh = npc_blueprint.skin_mesh
	$Skeleton/hair.mesh = npc_blueprint.hair_mesh
	$Skeleton/clothes.mesh = npc_blueprint.clothes_mesh
	$Skeleton/shoes.mesh = npc_blueprint.shoes_mesh

