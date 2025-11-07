@abstract class_name DatabaseObject extends Resource

@export var id: StringName
@export var name: String

func _to_rich_string() -> String:
	return "%s" % [name]

func _to_string() -> String:
	return "%s(%s)" % [get_class_name(), id]

func get_class_name() -> String:
	var rm := RegEx.create_from_string(r'class_name\s+(\w+)').search(get_script().source_code)
	var clss_name := rm.strings[1]
	return clss_name

func get_state() -> Dictionary[StringName, Variant]:
	var out: Dictionary[StringName, Variant]
	for prop in get_property_list():
		if prop.usage & PROPERTY_USAGE_STORAGE and not (prop.usage & PROPERTY_USAGE_EDITOR):
			out[prop.name] = self[prop.name]
	return out
