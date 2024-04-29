extends State

var npc
var target

func enter():
	npc = owner
	target = npc.get_node(npc.target)

func handle_input(_event):
	pass

func update(_delta:float):
	pass

func physics_update(_delta:float):
	npc.current_speed = npc.walk_to(target)

func exit():
	pass
