const PHYSICS_LAYERS := {
	"DEFAULT": 1,
	"COLLECTIBLES": 2,
	"ENEMIES": 3,
	"TRIGGERS": 4,
	"PLAYER": 5,
	"NPCS": 6
}

const PHYSICS_LAYER_NAMES := {
	1: "DEFAULT",
	2: "COLLECTIBLES",
	3: "ENEMIES",
	4: "TRIGGERS",
	5: "PLAYER",
	6: "NPCS"
}

# Optional helper function
func get_layer_name_from_mask(mask: int) -> String:
	var layers = {}
	for i in range(1, 21):
		var layer_name = ProjectSettings.get_setting("layer_names/3d_physics/layer_" + str(i))
		if layer_name != "":
			layers[layer_name] = pow(2, i - 1)

	for i in range(1, 21):
		if mask & (1 << (i - 1)):
			return PHYSICS_LAYER_NAMES.get(i, "UNKNOWN")

	return "NONE"