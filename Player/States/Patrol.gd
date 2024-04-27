extends State

#	Player scene nodes
var player
var camera
var animation

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
var direction
var gravity
var vertical_velocity
var velocity

#	Target profiling variables
var subject_in_range
var profiling_target

func enter():
	print("Patrol Mode")
	player = owner
	pivot_x = player.get_node(player.pivot_x)
	pivot_y = player.get_node(player.pivot_y)
	orbit_acceleration = player.orbit_acceleration
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
	pass

func exit():
	pass
