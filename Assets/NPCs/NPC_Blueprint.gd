class_name NpcBlueprint
extends Resource

# Racial/Economic/Social stats
export(Dictionary) var base_stats = {
	name = "Juan Pérez",
	race = 0.5,
	economy = 0.5,
	social = 0.5
}

# Mesh construction
export(Mesh) var eyes_mesh
export(Mesh) var skin_mesh
export(Mesh) var hair_mesh
export(Mesh) var clothes_mesh
export(Mesh) var shoes_mesh

