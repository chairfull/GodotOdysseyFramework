class_name UBit extends RefCounted

const FLAG_NONE := 0

# Static cache for layer mappings (avoids repeated ProjectSettings lookups)
static var _physics3d_cache: Dictionary = {}
static var _render3d_cache: Dictionary = {}

static func is_enabled(b: int, flag: int) -> bool:
	return (b & flag) != 0

static func enable(b: int, flag: int) -> int:
	return b | flag

static func disable(b: int, flag: int) -> int:
	return b & ~flag

static func is_physics3d_enabled(id: StringName, b: int) -> bool:
	var flag := get_physics3d_flag(id)
	return flag != 0 and is_enabled(b, flag)

static func enable_physics3d(id: StringName, b: int) -> int:
	var flag := get_physics3d_flag(id)
	return enable(b, flag) if flag != 0 else b

static func disable_physics3d(id: StringName, b: int) -> int:
	var flag := get_physics3d_flag(id)
	return disable(b, flag) if flag != 0 else b

static func build_physics3d_mask(...ids) -> int:
	var out := 0
	for id in ids:
		var flag := get_physics3d_flag(id)
		if flag != 0:
			out = enable(out, flag)
	return out

static func get_physics3d_flag(id: StringName) -> int:
	if _physics3d_cache.has(id):
		return _physics3d_cache[id]
	
	for layer in range(1, 33):
		if ProjectSettings.get_setting("layer_names/3d_physics/layer_%d" % layer) == id:
			var mask := 1 << (layer - 1)
			_physics3d_cache[id] = mask
			return mask
	
	push_error("No 3D physics layer named '%s' found." % id)
	return 0

static func get_render3d_flag(id: StringName) -> int:
	if _render3d_cache.has(id):
		return _render3d_cache[id]
	
	for layer in range(1, 33):
		if ProjectSettings.get_setting("layer_names/3d_render/layer_%d" % layer) == id:
			var mask := 1 << (layer - 1)
			_render3d_cache[id] = mask
			return mask
	
	push_error("No 3D render layer named '%s' found." % id)
	return 0

static func build_render3d_mask(...ids) -> int:
	var out := 0
	for id in ids:
		var flag := get_render3d_flag(id)
		if flag != 0:
			out = enable(out, flag)
	return out
