extends State

func enter():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func handle_input(_event):
	if InputMap.event_is_action(_event, "ui_cancel"):
		state_machine.transition_to("Patrol")
		owner.profiling_target.state_machine.transition_to("WalkTo")

func update(_delta:float):
	pass

func physics_update(_delta:float):
	pass

func exit():
	pass
