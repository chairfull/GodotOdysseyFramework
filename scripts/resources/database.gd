class_name Database extends Resource

@export var _objects: Dictionary[StringName, DatabaseObject]
var _default_state: Dictionary[StringName, Dictionary]

func size() -> int:
	return _objects.size()

## Used by State class.
func connect_signals() -> void:
	pass

func update_default_state():
	_default_state = get_state()

func get_changed_state():
	var state := get_state()
	var out: Dictionary[StringName, Dictionary]
	for item_id in state:
		var item_state := state[item_id]
		if item_id in _default_state:
			var default_state := _default_state[item_id]
			for prop in default_state:
				if item_state[prop] != default_state[prop]:
					if not item_id in out:
						out[item_id] = {}
					out[item_id][prop] = item_state[prop]
	return out
	
func get_state() -> Dictionary[StringName, Dictionary]:
	var out: Dictionary[StringName, Dictionary]
	for item_id in _objects:
		out[item_id] = _objects[item_id].get_state()
	return out

func has(id: StringName) -> bool:
	return id in _objects

func find(id: StringName, default: DatabaseObject = null, silent := false) -> DatabaseObject:
	if has(id):
		return _objects[id]
	if not silent:
		push_error("No item %s in %s. %s" % [id, self, _objects.keys()])
	return default

func find_id(data: DatabaseObject) -> StringName:
	for id in _objects:
		if _objects[id] == data:
			return id
	return &""

func get_ids() -> PackedStringArray:
	return PackedStringArray(_objects.keys())

func merge(db: Database):
	for id in db._objects:
		if id in _objects:
			push_warning("DB Merge: Overriding %s." % id)
		_objects[id] = db._objects[id]

func _add(id: StringName, obj: DatabaseObject, props := {}, silent := false) -> DatabaseObject:
	if id in _objects:
		push_warning("Replacing %s." % [id])
	_objects[id] = obj
	obj.id = id
	for prop in props:
		if prop in obj:
			match typeof(obj[prop]):
				TYPE_DICTIONARY:
					var targ_dict: Dictionary = obj[prop]
					var source_dict: Dictionary = props[prop]
					for key in source_dict:
						targ_dict[key] = source_dict[key]
				TYPE_ARRAY: (obj[prop] as Array).assign(props[prop])
				var type: obj[prop] = convert(props[prop], type)
		elif prop == prop.to_upper(): pass # Skip ID and TYPE.
		elif not silent:
			push_error("Object %s has no property %s to set to %s." % [obj, prop, props[prop]])
	return obj

func _get(property: StringName) -> Variant:
	return _objects.get(property, null)

func _iter_init(iter: Array) -> bool:
	iter[0] = 0
	return iter[0] < _objects.size()

func _iter_next(iter: Array) -> bool:
	iter[0] += 1
	return iter[0] < _objects.size()

func _iter_get(iter: Variant) -> Variant:
	return _objects.values()[iter]

func get_object_script() -> GDScript:
	return null
