class_name Database extends Resource

@export var _objects: Dictionary[StringName, DatabaseObject]

func find(id: StringName, default: DatabaseObject = null, silent := true) -> DatabaseObject:
	if id in _objects:
		return _objects[id]
	if not silent:
		push_error("No item %s in %s." % [id, self])
	return default

func find_id(data: DatabaseObject) -> StringName:
	return _objects.find_key(data)

func get_ids() -> PackedStringArray:
	return PackedStringArray(_objects.keys())

func _get(property: StringName) -> Variant:
	return _objects.get(property, null)

func _iter_init(iter: Array) -> bool:
	iter[0] = 0
	return iter[0] < _objects.size()

func _iter_next(iter: Array) -> bool:
	iter[0] += 1
	return iter[0] < _objects.size()

func _iter_get(iter: Variant) -> Variant:
	return _objects[iter]

func get_object_script() -> GDScript:
	return null
