class_name UDict

static func pop(dict: Dictionary, key: Variant, default: Variant = null) -> Variant:
	if key in dict:
		var out: Variant = dict[key]
		dict.erase(key)
		return out
	return default

static func from(old: Dictionary, base: Dictionary) -> Dictionary:
	return Dictionary(base,\
		old.get_typed_key_builtin(), old.get_typed_key_class_name(), old.get_typed_key_script(),\
		old.get_typed_value_builtin(), old.get_typed_value_class_name(), old.get_typed_value_script())
