class_name StateObjects extends Resource

@export var chars: CharDB
@export var char_groups: CharGroupDB
@export var items: ItemDB
@export var zones: ZoneDB
@export var stats: StatDB
@export var quests: QuestDB
@export var attributes: AttributeDB
@export var inventories: InventoryDB
@export var equip_slots: Database

func _init() -> void:
	clear()

func get_dbs() -> Array[Database]:
	return [chars, items, zones, stats, quests]

func get_counts_string(join_str := ", ") -> String:
	var counts := []
	for db in get_dbs():
		var size: int = db.size()
		if size > 0:
			counts.append([size, UObj.get_class_name(db)])
	counts.sort_custom(func(a, b): return a[0] > b[0])
	return join_str.join(counts.map(func(a): return "%sx %s" % a))

func clear() -> void:
	chars = CharDB.new()
	char_groups = CharGroupDB.new()
	items = ItemDB.new()
	zones = ZoneDB.new()
	stats = StatDB.new()
	quests = QuestDB.new()
	attributes = AttributeDB.new()
	inventories = InventoryDB.new()
	equip_slots = Database.new()
