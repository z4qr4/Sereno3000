extends KinematicBody
class_name HumanNPC

export(Resource) var npc_blueprint

export var selected_material: ShaderMaterial
export var target_color = Color(1,1,1,1)
export var target_outline = 0.02

export var walk_speed = 1.2
export var target : NodePath

onready var state_machine = $StateMachine

var is_selected = false
var current_speed

onready var nav_agent = $NavigationAgent
var computed_velocity = Vector3.ZERO

func _ready():
	#initialize()
	pass

func _physics_process(delta):
	$Skeleton/AnimationTree["parameters/blend_position"] = current_speed
	pass

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
	skeleton.rotation_degrees = Vector3(0, 180, 0)
	add_child(skeleton)

func walk_to(current_target):
	var velocity = Vector3.ZERO
	if current_target != null:
		nav_agent.set_target_location(current_target.global_transform.origin)
#		velocity = (nav_agent.get_next_location() - global_transform.origin).normalized() * walk_speed
		velocity = global_translation.direction_to(nav_agent.get_next_location()) * walk_speed
		look_at(nav_agent.get_next_location(), Vector3.UP)
		nav_agent.set_velocity(velocity)
	if !is_on_floor():
		velocity.y -= 10
	if !nav_agent.is_navigation_finished():
		nav_agent.set_velocity(velocity)
		move_and_slide(computed_velocity)
		return velocity.length()
	else:
		return 0

func _on_NavigationAgent_velocity_computed(safe_velocity):
	computed_velocity = safe_velocity
