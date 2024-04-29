tool
class_name NpcSpawn
extends Spatial

export(float) var spawn_time = 2
export var target : NodePath

var spawn_timer

func _init():
	spawn_timer = Timer.new()
	spawn_timer.autostart = true
	spawn_timer.one_shot = true
	spawn_timer.connect("timeout", self, "timeout_spawn")
	add_child(spawn_timer)

func _ready():
	spawn_timer.wait_time = spawn_time

func timeout_spawn():
	spawn_npc()

func spawn_npc():
	var npc_constructor = load("res://Assets/NPCs/HumanNPC.tscn")
	var npc = npc_constructor.instance()
	npc.initialize()
	print("sending: " + target)
	npc.target = target
	npc.translation = translation
	get_parent().add_child(npc)
