extends Node
## Handles state of world in a way where non-loaded content can be set/get.

@warning_ignore("unused_signal") signal event(event: Event)

@export var characters: CharacterDB
@export var locations: LocationDB
@export var inventories: Database
@export var equipment_slots: Database
@export var items: ItemDB
@export var attributes: AttributeDB
@export var vars: Database
@export var quests: QuestDB

func _ready() -> void:
	reload()
	
	items.add(&"apple", "Apple")
	items.add(&"pear", "Pear")
	items.add(&"pineapple", "Pineapple")
	items.add(&"banana", "Banana")
	items.add(&"grape", "Grape")
	items.add(&"peach", "Peach")
	items.add(&"watermelon", "Watermelon")
	items.add(&"kiwi", "Kiwi")
	items.add(&"strawberry", "Strawberry")
	items.add(&"orange", "Orange")
	
	var q := QuestInfo.new()
	quests._add("q1", q)
	q.name = "First Quest"
	var tick1 := QuestTick.new()
	q.ticks.append(tick1)
	tick1.id = "find_apples"
	tick1.name = "Find Apples"
	var tick2 := QuestTick.new()
	q.ticks.append(tick2)
	tick2.id = "find_bananas"
	tick2.name = "Find Bananas"
	
	var q2 := QuestInfo.new()
	quests._add("q2", q2)
	q2.name = "2nd Quest"
	var qtick := QuestTick.new()
	qtick.name = "Kill Enemy"
	q2.ticks.append(qtick)

func reload():
	characters = CharacterDB.new()
	locations = LocationDB.new()
	inventories = Database.new()
	equipment_slots = Database.new()
	items = ItemDB.new()
	attributes = AttributeDB.new()
	vars = Database.new()
	quests = QuestDB.new()

func find_char(id: StringName) -> CharacterInfo: return characters.find(id)
func find_item(id: StringName) -> ItemInfo: return items.find(id)
func find_equipment_slot(id: StringName) -> EquipmentSlotInfo: return equipment_slots.find(id)
func find_attribute(id: StringName) -> AttributeInfo: return attributes.find(id)
func find_quest(id: StringName) -> QuestInfo: return quests.find(id)

#func run(expression: String) -> Variant:
	#var exx := Expression.new()
	#var err := exx.parse(expression, [])
	#if err != OK:
		#push_error(exx.get_error_text())
		#return false
	#return exx.execute([], self)
#
### 
#func test(expression: String) -> bool:
	#return true if run(expression) else false
