class_name ItemDB extends Database

func add(id: StringName, name: String, desc := "", props := {}) -> ItemInfo:
	var itm := ItemInfo.new()
	itm.name = name
	itm.desc = desc
	return _add(id, itm, props)

func get_field_script() -> GDScript:
	return ItemInfo
