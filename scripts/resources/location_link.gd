class_name LocationLink extends Resource

@export var type: StringName
@export var locked := false
@export var opened := false
@export var password := ""
var a: LocationInfo
var b: LocationInfo

func _to_string() -> String:
	return "LocationLink(%s <-> %s)" % [a.id, b.id]

func _set(property: StringName, _value: Variant) -> bool:
	match property:
		&"links":
			#var parts: PackedStringArray = value.split(" ", true, 1)
			#var from := parts[0].split("/", true, 1)
			#from_zone.id = from[0]
			#from_area_id = from[1]
			#var to := parts[1].split("/", true, 1)
			#to_zone_id = to[0]
			#to_area_id = to[1]
			return true
	return false

func get_inverse(loc: LocationInfo) -> LocationInfo:
	if loc == a: return b
	if loc == b: return a
	push_error("Link doesn't connect to %s." % [loc])
	return null
