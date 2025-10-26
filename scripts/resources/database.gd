class_name Database extends Resource

@export var items: Dictionary[StringName, DatabaseItem]

func find(id: StringName) -> DatabaseItem:
	if id in items:
		return items[id]
	push_error("No item %s in %s." % [id, self])
	return null

func find_id(data: DatabaseItem) -> StringName:
	return items.find_key(data)

func get_ids() -> PackedStringArray:
	return PackedStringArray(items.keys())

func _get(property: StringName) -> Variant:
	return items.get(property, null)

func _iter_init(iter: Array) -> bool:
	iter[0] = 0
	return iter[0] < len(items)

func _iter_next(iter: Array) -> bool:
	iter[0] += 1
	return iter[0] < len(items)

func _iter_get(iter: Variant) -> Variant:
	return items[iter]
