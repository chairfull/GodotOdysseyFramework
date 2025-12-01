class_name UList extends RefCounted

static func from(old: Array, base: Array) -> Array:
	return Array(base,\
		old.get_typed_builtin(), old.get_typed_class_name(), old.get_typed_script())

static func append_unique(list: Array, other: Array) -> Array:
	for item in other:
		if not item in list:
			list.append(item)
	return list
