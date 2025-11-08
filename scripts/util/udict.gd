class_name UDict

static func pop(dict: Dictionary, key: Variant, default: Variant = null) -> Variant:
	if key in dict:
		var out: Variant = dict[key]
		dict.erase(key)
		return out
	return default
