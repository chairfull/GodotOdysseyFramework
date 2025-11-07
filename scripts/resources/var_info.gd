class_name VarInfo extends DatabaseObject

@export var value: Variant: set=set_value
@export var desc: String
@export var allowed: Array[Variant]
@export var minimum: Variant = null
@export var maximum: Variant = null
@export var default: Variant

func set_value(v: Variant) -> bool:
	var type := typeof(default)
	var converted: Variant = type_convert(v, type)
	if minimum: converted = min(minimum, converted)
	if maximum: converted = min(maximum, converted)
	if allowed and not converted in allowed:
		push_error("Couldn't set %s to %s. Only %s allowed." % [id, v, allowed])
		return false
	if value == converted: return false
	value = converted
	return true
