extends Node
## Handles state of world in a way where non-loaded content can be set/get.

@warning_ignore("unused_signal") signal event(event: Event)

@export var characters: CharacterDB
@export var locations: LocationDB
@export var inventories: Database
@export var equipment_slots: Database
@export var items: ItemDB
@export var attributes := AttributeDB.new()

func find_char(id: StringName) -> CharacterInfo: return characters.find(id)
func find_item(id: StringName) -> ItemInfo: return items.find(id)
func find_equipment_slot(id: StringName) -> EquipmentSlotInfo: return equipment_slots.find(id)
func find_attribute(id: StringName) -> AttributeInfo: return attributes.find(id)

func save_slot(slot: StringName):
	var _dir := "user://saves/".path_join(slot)

func load_slot(slot: StringName):
	var _dir := "user://saves/".path_join(slot)
