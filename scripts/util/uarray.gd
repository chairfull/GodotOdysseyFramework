class_name UArray extends RefCounted

static func from(old: Array, base: Array) -> Array:
	return Array(base,\
		old.get_typed_builtin(), old.get_typed_class_name(), old.get_typed_script())
