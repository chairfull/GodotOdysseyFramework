class_name StateObjects extends Resource

const ORDER := [&"chars", &"items", &"zones", &"vars", &"quests"]

@export var chars: CharDB
@export var items: ItemDB
@export var zones: ZoneDB
@export var vars: VarDB
@export var quests: QuestDB
@export var attributes: AttributeDB
@export var inventories: Database
@export var equip_slots: Database

func _init() -> void:
	clear()

func get_counts_string(join_str := ", ") -> String:
	var counts := []
	for prop in ORDER:
		var size: int = self[prop].size()
		if size > 0:
			counts.append([size, prop])
	counts.sort_custom(func(a, b): return a[0] > b[0])
	return join_str.join(counts.map(func(a): return "%sx %s" % a))

func clear():
	chars = CharDB.new()
	items = ItemDB.new()
	zones = ZoneDB.new()
	vars = VarDB.new()
	quests = QuestDB.new()
	attributes = AttributeDB.new()
	inventories = Database.new()
	equip_slots = Database.new()

func get_dbs() -> Array[Database]:
	var out: Array[Database]
	for item in ORDER:
		out.append(self[item])
	return out
