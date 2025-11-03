class_name LocationLink extends Resource
## Used by AStar system.

@export var type: StringName
@export var locked := false
@export var opened := false
@export var password := ""
var a: LocationInfo
var b: LocationInfo

func _to_string() -> String:
	return "LocationLink(%s <-> %s)" % [a.id, b.id]

func get_inverse(loc: LocationInfo) -> LocationInfo:
	if loc == a: return b
	if loc == b: return a
	push_error("Link doesn't connect to %s." % [loc])
	return null
