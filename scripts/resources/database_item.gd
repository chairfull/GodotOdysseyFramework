@abstract class_name DatabaseObject extends Resource

var id: StringName:
	get: return get_db().find_id(self)

var name: String

func _init(kwargs := {}) -> void:
	for prop in kwargs:
		if prop in self:
			self[prop] = kwargs[prop]
		else:
			push_warning("No property '%s' in %s." % [prop, self])

func get_db() -> Database:
	return null

func _to_rich_string() -> String:
	return "%s" % [name]

func _to_string() -> String:
	#var lines := (get_script().source_code as String).split("\n", true, 1)
	#var clss_name := lines[0].split("class_name", true, 1)[-1].split(" ", true, 1)[0]
	var clss_name := resource_path.get_basename().get_file().capitalize()
	return "%s(%s)" % [clss_name, id]

func get_state() -> Dictionary[StringName, Variant]:
	var out: Dictionary[StringName, Variant]
	for prop in get_property_list():
		if prop.usage & PROPERTY_USAGE_STORAGE and not (prop.usage & PROPERTY_USAGE_EDITOR):
			out[prop.name] = self[prop.name]
	return out
