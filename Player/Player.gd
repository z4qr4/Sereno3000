class_name Player
extends KinematicBody

#	Variables for Camera Control
export var mouse_sensitivity = 0.1
export var orbit_acceleration = 10
export var camrot_v_min = -30
export var camrot_v_max = 75

onready var camrot_h = 0
onready var camrot_v = 0

var pivot_h
var pivot_v
export var pivot_x : NodePath
export var pivot_y : NodePath
var camera

# Variables for motion
export var walk_speed = 5
export var sprint_speed = 10
export var angular_acceleration = 10
export var acceleration = 6
export var model_path : NodePath

var direction = Vector3.FORWARD
var gravity = 9.8
var vertical_velocity = 0
var velocity = Vector3.ZERO
var model

# Variables for FacialProfiling
export var target_outline_thickness = 0.01
export var target_outline_color = Color(1,0,0,1)

var subjects_in_range = []
var profiling_target

onready var profiling_marker = $GUI/reticle

func _ready():	
#	Initialize variables for control rig:
	model = get_node(model_path)
	$CameraRoot/PivotH/PivotV/PlayerCamera.add_exception(self)
	pivot_h = get_node("CameraRoot/PivotH")
	pivot_v = get_node("CameraRoot/PivotH/PivotV")
	camera = get_node("CameraRoot/PivotH/PivotV/PlayerCamera")
	
#	Set default animation DELETE THIS WHEN CONFIGURING ACTUAL ANIMATION TREE
	$"S300_V3/Armature/AnimationPlayer".get_animation("Idle").loop = true
	$"S300_V3/Armature/AnimationPlayer".play("Idle")

func _input(event):
	pass

func _physics_process(delta):
	if profiling_target != null:
		var reticle_position = camera.unproject_position(profiling_target.get_node("CollisionShape").global_translation)
		profiling_marker.set_global_position(reticle_position)
		


func _on_AimingArea_target_selected(target):
	if target == null:
		profiling_target = null
		profiling_marker.visible = false
		profiling_marker.set_position(Vector2(0,0))
		for i in $GUI/HUD/BaseStats.get_children():
			i.queue_free()
	else:
		if profiling_target != null: profiling_target.set_selected(false)
		for i in $GUI/HUD/BaseStats.get_children():
			i.queue_free()
		profiling_target = target
		target.set_selected(true)
		for i in target.npc_blueprint.base_stats:
			var stat_label = Label.new()
			stat_label.text = i + str(target.npc_blueprint.base_stats[i])
			$GUI/HUD/BaseStats.add_child(stat_label)
		profiling_marker.visible = true
