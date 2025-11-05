class_name PropertyInfo extends DatabaseObject

@export var value: Variant: set=set_value
var desc: String
var allowed: Array[Variant]
var minimum: Variant = null
var maximum: Variant = null
var default: Variant

func set_value(v: Variant):
	var type := typeof(default)
	var converted: Variant = type_convert(v, type)
	if minimum: converted = min(minimum, converted)
	if maximum: converted = min(maximum, converted)
	if allowed and not converted in allowed:
		push_error("Couldn't set %s to %s. Only %s allowed." % [id, v, allowed])
		return
	if value == converted: return
	value = converted
	
