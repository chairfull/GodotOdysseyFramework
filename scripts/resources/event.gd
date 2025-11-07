class_name Event extends RefCounted

signal triggered(ev: Event, args)

var _signal: Signal = triggered
var _default: Dictionary[StringName, Variant]
var _current: Dictionary[StringName, Variant]

func _init(props := {}, sig: Signal = triggered) -> void:
	_signal = sig
	_default.assign(props)
	for prop in _default:
		_current[prop] = null

func _get(property: StringName) -> Variant:
	return _current.get(property, null)

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
	_signal.emit(self)
