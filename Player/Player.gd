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
	model = get_node(model_path)
	
#	Initialize camera control:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$CameraRoot/PivotH/PivotV/PlayerCamera.add_exception(self)
	pivot_h = get_node("CameraRoot/PivotH")
	pivot_v = get_node("CameraRoot/PivotH/PivotV")
	camera = get_node("CameraRoot/PivotH/PivotV/PlayerCamera")
	
#	Set default animation DELETE THIS WHEN CONFIGURING ACTUAL ANIMATION TREE
	$"S300_V3/Armature/AnimationPlayer".get_animation("Idle").loop = true
	$"S300_V3/Armature/AnimationPlayer".play("Idle")

func _input(event):
#	Get mouse motion for camera control:
	if event is InputEventMouseMotion:
		camrot_h -= event.relative.x
		camrot_v -= event.relative.y

func _physics_process(delta):
#	Move the camera rig with mouse motion values:
	camrot_v = clamp(camrot_v, camrot_v_min, camrot_v_max)
	pivot_h.rotation_degrees.y = lerp(pivot_h.rotation_degrees.y, camrot_h, delta * orbit_acceleration)
	pivot_v.rotation_degrees.x = lerp(pivot_v.rotation_degrees.x, camrot_v, delta * orbit_acceleration)
	
#	Move the character with input, might be replaced with more elegant movement:
	var movement_speed = 0
	
	if Input.is_action_pressed("move_fw") || Input.is_action_pressed("move_bw") || Input.is_action_pressed("move_l") || Input.is_action_pressed("move_r"):
		var h_rotation = pivot_h.global_transform.basis.get_euler().y		
		direction = Vector3(Input.get_action_strength("move_l") - Input.get_action_strength("move_r"),
		0,
		Input.get_action_strength("move_fw") - Input.get_action_strength("move_bw")).rotated(Vector3.UP, h_rotation).normalized()
		model.rotation.y = lerp_angle(model.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
		if Input.is_action_pressed("sprint"):
			movement_speed = sprint_speed
		else:
			movement_speed = walk_speed
	
	velocity = lerp(velocity, direction * movement_speed, delta * acceleration)
	move_and_slide(velocity + vertical_velocity * Vector3.DOWN, Vector3.UP)
	
	if !is_on_floor():
		vertical_velocity += delta * gravity
	else:
		vertical_velocity = 0
	
#	Target the closest subject in range:
	if profiling_target != null:
		var reticle_position = camera.unproject_position(profiling_target.get_node("CollisionShape").global_translation)
		profiling_marker.set_global_position(reticle_position)
		


func _on_AimingArea_target_selected(target):
	if target == null:
		print("No target")
		profiling_target = null
		profiling_marker.visible = false
		profiling_marker.set_position(Vector2(0,0))
	else:
		if profiling_target != null: profiling_target.set_selected(false)
		profiling_target = target
		target.set_selected(true)
		for i in target.npc_blueprint.base_stats:
			print(i + ": " + str(target.npc_blueprint.base_stats[i]))
		profiling_marker.visible = true
