extends KinematicBody

export var walk_speed = 5
export var target: NodePath

onready var nav_agent = $NavigationAgent

func _physics_process(delta):
	walk_to()

func walk_to():
	var velocity = Vector3.ZERO
	var realized_target = get_node(target)
	if realized_target != null:
		nav_agent.set_target_location(realized_target.global_transform.origin)
		velocity = (nav_agent.get_next_location() - global_transform.origin).normalized() * walk_speed
		look_at(nav_agent.get_next_location(), Vector3.UP)
	if nav_agent.distance_to_target() > 1:
		move_and_slide(velocity)

