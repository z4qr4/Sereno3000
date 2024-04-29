extends State

#	Player scene nodes
var player
var camera
var animation
var model

#	Camera rig variables
var mouse_sensitivity
var orbit_acceleration
var camrot_x = 0
var camrot_y = 0
var pivot_x
var pivot_y
var camrot_x_min = -30
var camrot_x_max = 75

#	Movement variables
var walk_speed
var sprint_speed
var angular_acceleration
var acceleration
var direction = Vector3.FORWARD
var gravity = 9.8
var vertical_velocity = 0
var velocity = Vector3.ZERO

#	Target profiling variables
var subject_in_range
var profiling_target


çfunc enter():
	print("Patrol Mode")
	player = owner
	pivot_x = player.get_node(player.pivot_x)
	pivot_y = player.get_node(player.pivot_y)
	model = player.model
	acceleration = player.acceleration
	angular_acceleration = player.angular_acceleration
	orbit_acceleration = player.orbit_acceleration
	walk_speed = player.walk_speed
	sprint_speed = player.sprint_speed
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func handle_input(_event):
	if _event is InputEventMouseMotion:
		camrot_x -= _event.relative.y
		camrot_y -= _event.relative.x

func update(_delta:float):
	camrot_x = clamp(camrot_x, camrot_x_min, camrot_x_max)
	pivot_x.rotation_degrees.x = lerp(pivot_x.rotation_degrees.x, camrot_x, _delta * orbit_acceleration)
	pivot_y.rotation_degrees.y = lerp(pivot_y.rotation_degrees.y, camrot_y, _delta * orbit_acceleration)

func physics_update(_delta:float):
	var movement_speed = 0
	
	if Input.is_action_pressed("move_fw") || Input.is_action_pressed("move_bw") || Input.is_action_pressed("move_l") || Input.is_action_pressed("move_r"):
		var h_rotation = pivot_y.global_transform.basis.get_euler().y
		direction = Vector3(Input.get_action_strength("move_l") - Input.get_action_strength("move_r"),
		0,
		Input.get_action_strength("move_fw") - Input.get_action_strength("move_bw")).rotated(Vector3.UP, h_rotation).normalized()
		model.rotation.y = lerp_angle(model.rotation.y, atan2(direction.x, direction.z), _delta * angular_acceleration)
		
		if Input.is_action_pressed("sprint"):
			movement_speed = sprint_speed
		else:
			movement_speed = walk_speed
	
	velocity = lerp(velocity, direction * movement_speed, _delta * acceleration)
	player.move_and_slide(velocity + vertical_velocity * Vector3.DOWN, Vector3.UP)
	
	if !player.is_on_floor():
		vertical_velocity += _delta * gravity
	else:
		vertical_velocity = 0

func exit():
	pass
