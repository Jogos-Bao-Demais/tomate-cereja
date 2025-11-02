const PHYSICS_LAYERS := {
	"DEFAULT": 1,
	"PIPES": 2,
	"ENEMIES": 5,
	"TRIGGERS": 6,
	"PLAYER": 7,
	"NPCS": 8
}

const PHYSICS_LAYER_NAMES := {
	1: "DEFAULT",
	4: "COLLECTIBLES",
	5: "ENEMIES",
	6: "TRIGGERS",
	7: "PLAYER",
	8: "NPCS"
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
