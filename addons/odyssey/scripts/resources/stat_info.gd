class_name StatInfo extends DatabaseObject

@export var value: Variant = null: set=set_value
@export var desc: String
@export var allowed: Array[Variant]
@export var minimum: Variant = null
@export var maximum: Variant = null
@export var default: Variant = null:
	set(d):
		default = d
		if value == null:
			value = default

func set_value(v: Variant) -> bool:
	var type := typeof(default)
	var converted: Variant = type_convert(v, type)
	if minimum: converted = min(minimum, converted)
	if maximum: converted = min(maximum, converted)
	if allowed and not converted in allowed:
		push_error("Couldn't set %s to %s. Only %s allowed." % [id, v, allowed])
		return false
	if value == converted: return false
	var old: Variant = value
	value = converted
	World.STAT_CHANGED.fire({ stat=self, old=old, new=value })
	return true
