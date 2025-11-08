class_name Event extends RefCounted

signal emitted(ev: Event)

var _default: Dictionary[StringName, Variant]
var _current: Dictionary[StringName, Variant]

func _init(props := {}) -> void:
	_default.assign(props)
	for prop in _default:
		if _default[prop] is int:
			_current[prop] = type_convert(null, _default[prop])
		else:
			_current[prop] = type_convert(null, typeof(_default[prop]))

func _get(property: StringName) -> Variant:
	return _current.get(property, null)

func get_bool(property: StringName, default := false) -> bool: return _current.get(property, default)
func get_int(property: StringName, default := 0) -> int: return _current.get(property, default)
func get_float(property: StringName, default := 0.0) -> float: return _current.get(property, default)
func get_str(property: StringName, default := "") -> String: return _current.get(property, default)
func get_str_name(property: StringName, default := &"") -> StringName: return _current.get(property, default)
func get_dict(property: StringName, default := {}) -> Dictionary: return _current.get(property, default)
func get_array(property: StringName, default := []) -> Array: return _current.get(property, default)

func connect_to(method: Callable):
	emitted.connect(method)

func test(props: Dictionary) -> bool:
	for prop in props:
		if not prop in _current: continue
		elif _current[prop] is DatabaseObject and typeof(props[prop]) in [TYPE_STRING, TYPE_STRING_NAME]:
			if _current[prop].id != props[prop]: return false
		elif _current[prop] != props[prop]: return false
	return true

func emit(kwargs: Dictionary = {}):
	for prop in kwargs:
		if prop in _default:
			_current[prop] = kwargs[prop]
		else:
			push_warning("Event has no property %s. (%s)" % [prop, self])
	print("EV CUR: ", _current)
	State.event.emit(self)
	emitted.emit(self)
