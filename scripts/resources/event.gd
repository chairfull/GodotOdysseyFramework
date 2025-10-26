class_name Event extends RefCounted

signal triggered(ev: Event, args)

var _signal: Signal = triggered
var _properties: Dictionary[StringName, Variant]

func _init(sig: Signal = triggered, props := {}) -> void:
	_signal = sig
	for prop in props:
		_properties[prop] = props[prop]

func _get(property: StringName) -> Variant:
	return _properties.get(property, null)

func emit(data: Variant = null, kwargs: Dictionary = {}):
	for prop in kwargs:
		if prop in self:
			self[prop] = kwargs[prop]
		elif prop in _properties:
			_properties[prop] = kwargs[prop]
		else:
			push_warning("Event has no property %s. (%s)" % [prop, self])
	_signal.emit(self, data)
