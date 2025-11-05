class_name UState extends RefCounted

static func get_state(obj: Object) -> Dictionary:
	var state: Dictionary[StringName, Variant]
	for prop in obj.get_property_list():
		if not prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == 0: continue
		match prop.type:
			TYPE_OBJECT: state[prop.name] = get_state(obj[prop.name])
			TYPE_DICTIONARY: state[prop.name] = _get_state_dict(obj[prop.name])
			TYPE_ARRAY: state[prop.name] = _get_state_array(obj[prop.name])
	return state

static func set_state(obj: Object, state: Dictionary[StringName, Variant]):
	for prop in obj.get_property_list():
		if not prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == 0: continue
		if not prop in state: continue
		match prop.type:
			TYPE_OBJECT: set_state(obj[prop.name], state[prop.name])
			TYPE_DICTIONARY: _set_state_dict(obj[prop.name], state[prop.name])
			TYPE_ARRAY: _set_state_array(obj[prop.name], state[prop.name])

static func _set_state_dict(dict: Dictionary, state: Dictionary):
	var val_type := dict.get_typed_value_builtin()
	match val_type:
		TYPE_OBJECT:
			var dclass := dict.get_typed_value_class_name()
			for key in state:
				var inst: Variant = ClassDB.instantiate(dclass)
				set_state(inst, state[key])
				dict[key] = inst
		_:
			for key in state:
				dict[key] = state[key]

static func _set_state_array(array: Array, state: Array):
	var atype := array.get_typed_builtin()
	match atype:
		TYPE_OBJECT:
			var aclass := array.get_typed_class_name()
			if aclass:
				for substate in state:
					var inst: Variant = ClassDB.instantiate(aclass)
					set_state(inst, substate)
					array.append(inst)
			else:
				array.assign(state)
		_: array.assign(state)

static func _get_state_dict(dict: Dictionary) -> Dictionary:
	var out: Dictionary[Variant, Variant]
	for prop in dict:
		match typeof(dict[prop]):
			TYPE_OBJECT: out[prop] = get_state(dict[prop])
			TYPE_DICTIONARY: out[prop] = _get_state_dict(dict[prop])
			TYPE_ARRAY: out[prop] = _get_state_array(dict[prop])
			_: out[prop] = dict[prop]
	return out

static func _get_state_array(array: Array) -> Array[Variant]:
	var out: Array[Variant]
	for item in array:
		match typeof(item):
			TYPE_OBJECT: out.append(get_state(item))
			TYPE_DICTIONARY: out.append(_get_state_dict(item))
			TYPE_ARRAY: out.append(_get_state_array(item))
			_: out.append(item)
	return out
