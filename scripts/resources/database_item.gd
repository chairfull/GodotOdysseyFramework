@abstract class_name DatabaseItem extends Resource

var id: StringName:
	get: return get_db().find_id(self)

func _init(kwargs := {}) -> void:
	for prop in kwargs:
		if prop in self:
			self[prop] = kwargs[prop]
		else:
			push_warning("No property '%s' in %s." % [prop, self])

func get_db() -> Database:
	return null
