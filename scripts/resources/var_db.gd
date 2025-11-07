class_name VarDB extends Database

func _get(property: StringName) -> Variant:
	if has(property):
		var prop: VarInfo = _objects[property]
		return prop.value
	return null

func _set(property: StringName, value: Variant) -> bool:
	if has(property):
		var prop: VarInfo = _objects[property]
		prop.set_value(value)
		return true
	return false

func add_range(id: StringName, default: Variant, minn: Variant = 0, maxx: Variant = 100, desc := "") -> VarInfo:
	var prop := VarInfo.new()
	prop.default = default
	prop.value = default
	prop.minimum = minn
	prop.maximum = maxx
	prop.desc = desc
	return _add(id, prop)
	
func add_flag(id: StringName, default: Variant = false, allowed := [true, false], desc := "") -> VarInfo:
	var prop := VarInfo.new()
	prop.default = default
	prop.value = default
	prop.allowed.assign(allowed)
	prop.desc = desc
	return _add(id, prop)

func get_object_script() -> GDScript:
	return VarInfo
