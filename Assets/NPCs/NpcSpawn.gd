tool
class_name NpcSpawn
extends Spatial

export(float) var spawn_time = 1.0

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
	print("Spawner timed-out, here's an NPC")

func spawn_npc():
	var npc_constructor = load("res://Assets/NPCs/HumanNPC.tscn")
	var npc = npc_constructor.instance()
	npc.initialize()
	add_child(npc)
