extends StateBase

### Handles state of world in a way where non-loaded content can be set/get.
#
#@warning_ignore("unused_signal") signal event(event: Event)
#
#var ZONE_ENTERED := Event.new({ zone=ZoneInfo, who=CharInfo }, event)
#var ZONE_EXITED := Event.new({ zone=ZoneInfo, who=CharInfo }, event)
#var QUEST_STARTED := Event.new({ quest=QuestInfo }, event)
#var QUEST_TICKED := Event.new({ quest=QuestInfo }, event)
#
#@export var objects: StateObjects
#@export var _conditions_errored: Array[StringName]
#@export var _conditions_script: GDScript
#var dbs: Array[Database]
#
#func _ready() -> void:
	#reload()
	#
	#var items := objects.items
	#items.add(&"apple", "Apple")
	#items.add(&"pear", "Pear")
	#items.add(&"pineapple", "Pineapple")
	#items.add(&"banana", "Banana")
	#items.add(&"grape", "Grape")
	#items.add(&"peach", "Peach")
	#items.add(&"watermelon", "Watermelon")
	#items.add(&"kiwi", "Kiwi")
	#items.add(&"strawberry", "Strawberry")
	#items.add(&"orange", "Orange")
	#
	##var quests := objects.quests
	##var q := QuestInfo.new()
	##quests._add("q1", q)
	##q.name = "First Quest"
	##var tick1 := QuestTick.new()
	##q.ticks.append(tick1)
	##tick1.id = "find_apples"
	##tick1.name = "Find Apples"
	##var tick2 := QuestTick.new()
	##q.ticks.append(tick2)
	##tick2.id = "find_bananas"
	##tick2.name = "Find Bananas"
	#
	##var q2 := QuestInfo.new()
	##quests._add("q2", q2)
	##q2.name = "2nd Quest"
	##var qtick := QuestTick.new()
	##qtick.name = "Kill Enemy"
	##q2.ticks.append(qtick)
#
#func reload():
	#objects = StateObjects.new()
	#dbs = objects.get_dbs()
	#_conditions_script = GDScript.new()
	#_conditions_errored.clear()
	#
	#var mods := Mods.get_enabled()
	#var vars := []
	#
	#for mod: ModInfo in mods:
		## Compile conditions script.
		#_conditions_script.source_code += mod._debug_gdscript.source_code + "\n"
		## Add items.
		#for prop in StateObjects.ORDER:
			#var db1: Database = objects[prop]
			#var db2: Database = mod[prop]
			#db1.merge(db2)
		## Collect unique variables used in conditions script.
		#for v in mod._debug_vars:
			#if not v in vars:
				#vars.append([v, mod._debug_vars[v]])
	#
	## For variables that don't exist in any database, block their functions.
	#for v in vars:
		#if not v[0] in self:
			#push_error("No property %s in state. Ignoring: %s." % [v[0], ",".join(v[1])])
			#_conditions_errored.append_array(v[1])
	#
	#for db in dbs:
		#db.connect_signals()
	#
	#Global.msg("State", "Reloaded", [objects.get_counts_string()])
#
#func find_char(id: StringName) -> CharInfo: return objects.chars.find(id)
#func find_item(id: StringName) -> ItemInfo: return objects.items.find(id)
#func find_zone(id: StringName) -> ItemInfo: return objects.zones.find(id)
#func find_equipment_slot(id: StringName) -> EquipmentSlotInfo: return objects.equipment_slots.find(id)
#func find_attribute(id: StringName) -> AttributeInfo: return objects.attributes.find(id)
#func find_quest(id: StringName) -> QuestInfo: return objects.quests.find(id)
#
#func test_condition(condition_method: StringName) -> bool:
	#if not _conditions_script.has_method(condition_method):
		#push_error("No condition method %s." % condition_method)
		#return false
	#if condition_method in _conditions_errored:
		#push_error("Skipping %s as it has non-existing variables." % [condition_method])
		#return false
	#return _conditions_script.call(condition_method)
	#
#func _get(property: StringName) -> Variant:
	#for db in dbs:
		#if db.has(property):
			#return db.get(property)
	#return null
#
#func _set(property: StringName, value: Variant) -> bool:
	#for db in dbs:
		#if db.has(property):
			#db.set(property, value)
			#return true
	#return false
