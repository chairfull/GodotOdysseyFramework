class_name Item extends DatabaseItem

static var db: ItemDB:
	get: return State.items

static func find(item_id: StringName) -> Item:
	return db.find(item_id)

@export var name: String

func get_db() -> Database:
	return State.items

func _node_equipped(node: ItemNode): pass
func _node_unequipped(node: ItemNode): pass
func _node_use(node: ItemNode): pass
func _node_reload(node: ItemNode): pass
