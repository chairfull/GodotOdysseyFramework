@abstract class_name DatabaseObject extends Resource

@export var id: StringName
@export var name: String
@export var tags: Array[PackedStringArray]

## Used with RichTextLabels.
func _to_rich_string() -> String:
	return "%s" % [name]

func _to_string() -> String:
	return "%s(%s)" % [UObj.get_class_name(self), id]

## Should be a World.database.
func get_db() -> Database:
	return null

## Has any tag?
func tagged_any(...tgs: Array) -> bool:
	for tag in tgs: if tag in tags: return true
	return false

## Has all tags?
func tagged(...tgs: Array) -> bool:
	for tag in tgs: if not tag in tags: return false
	return true

## Override. Will mark in database as having had a state change.
func has_notification() -> bool: return false
## Override. Mark as player has seen this.
func clear_notification() -> void: pass
func mark_notification() -> void: pass

func get_state() -> Dictionary[StringName, Variant]:
	var out: Dictionary[StringName, Variant]
	for prop in get_property_list():
		if not UBit.is_enabled(prop.usage, PROPERTY_USAGE_STORAGE): continue
		if UBit.is_enabled(prop.usage, PROPERTY_USAGE_EDITOR): continue
		out[prop.name] = self[prop.name]
	return out

func msg(text: String, args := [], kwargs := {}) -> void:
	if args:
		text += " " + ", ".join(args)
	if kwargs:
		text += " "
		for key in kwargs:
			text += "%s: %s"
	print_rich("[color=#%s][%s] [i]%s[/i][/color] (%s:%s)" % [Color.GOLD.to_html(), name, text, id, UObj.get_class_name(self)])
