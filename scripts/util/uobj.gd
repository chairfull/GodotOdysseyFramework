class_name UObj extends RefCounted

static func get_class_name(obj: Object) -> String:
	var scr: GDScript = obj.get_script()
	var scode := scr.source_code
	var rm := RegEx.create_from_string(r'class_name\s+(\w+)').search(scode)
	var clss_name := rm.strings[1]
	return clss_name

static func set_properties(obj: Object, props: Dictionary, silent := true) -> Object:
	for prop in props:
		if prop in obj:
			match typeof(obj[prop]):
				TYPE_DICTIONARY: (obj[prop] as Dictionary).assign(props[prop])
				TYPE_ARRAY: (obj[prop] as Array).assign(props[prop])
				TYPE_OBJECT: set_properties(obj[prop], props[prop], silent)
				TYPE_NIL: obj[prop] = props[prop] # Variant? Just flat out set it.
				var type: obj[prop] = convert(props[prop], type)
		elif prop == prop.to_upper():
			pass # Skip ID and TYPE.
		elif not silent:
			push_error("Object %s has no property %s to set to %s." % [obj, prop, props[prop]])
	return obj
