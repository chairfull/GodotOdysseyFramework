class_name UObj extends RefCounted

static func set_properties(obj: Object, props: Dictionary, silent := true) -> Object:
	for prop in props:
		if prop in obj:
			match typeof(obj[prop]):
				TYPE_DICTIONARY: (obj[prop] as Dictionary).assign(props[prop])
				TYPE_ARRAY: (obj[prop] as Array).assign(props[prop])
				TYPE_OBJECT: set_properties(obj[prop], props[prop], silent)
				var type: obj[prop] = convert(props[prop], type)
		elif prop == prop.to_upper():
			pass # Skip ID and TYPE.
		elif not silent:
			push_error("Object %s has no property %s to set to %s." % [obj, prop, props[prop]])
	return obj
