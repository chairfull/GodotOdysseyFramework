@tool
class_name ModInfo extends StateObjects

@export var mod_name := "Unnamed Mod"
@export var mod_desc := "Adds features."
@export var mod_author := "Author"
@export var mod_version := "0.0.1"
@export_global_dir var data_dir: String: ## Directory to scan for data files.
	get: return data_dir if data_dir else resource_path.get_base_dir()
@export_multiline var _debug_info := ""
@export var _script_conds: Dictionary[int, String]
@export var _script_exprs: Dictionary[int, String]

@export var awards: AwardDB

func clear() -> void:
	super()
	awards = AwardDB.new()

func get_persistent_dbs() -> Array[Database]:
	return [awards]

func load_dir(dir: String) -> void:
	data_dir = dir
	_load_dir(dir)
	_debug_info = get_counts_string("\n")

func _load_dir(dir: String) -> void:
	for subdir in DirAccess.get_directories_at(dir):
		_load_dir(dir.path_join(subdir))
	for file in DirAccess.get_files_at(dir):
		var path := dir.path_join(file)
		match file.get_extension():
			"json": _load_json(path)
			"yaml": _load_yaml(path)

func _load_yaml(file: String) -> void:
	var yaml_str := FileAccess.get_file_as_string(file)
	var yaml_result := YAML.parse(yaml_str)
	if yaml_result.has_error():
		push_error(yaml_result.get_error())
		return
	var data: Variant = yaml_result.get_data()
	_load_data(data)

func _load_json(file: String) -> void:
	var json := FileAccess.get_file_as_string(file)
	var data: Variant = JSON.parse_string(json)
	_load_data(data)

func _load_data(data: Variant):
	if data is Dictionary: data = [data]
	for dict: Dictionary in data:
		var type: StringName = dict.get(&"TYPE", &"")
		match type:
			&"mod_info":
				mod_name = dict.get(&"name", mod_name)
				mod_desc = dict.get(&"desc", mod_desc)
				mod_author = dict.get(&"author", mod_author)
				mod_version = dict.get(&"version", mod_version)
				
			&"char", &"character":
				var id: StringName = dict.get(&"ID", &"")
				chars._add(id, CharInfo.new(), dict)
			&"char_list", &"characters":
				var char_list: Dictionary = dict.get(type)
				for id in char_list:
					chars._add(id, CharInfo.new(), char_list[id])
			&"item":
				var id: StringName = dict.get(&"ID", &"")
				items._add(id, ItemInfo.new(), dict)
			&"items", &"item_list":
				var item_list: Dictionary = dict.get(type)
				for id in item_list:
					items._add(id, ItemInfo.new(), item_list[id])
			
			&"stat":
				var id: StringName = dict.get(&"ID", &"")
				stats._add(id, StatInfo.new(), dict)
			&"stats":
				var stat_list: Dictionary = dict.get(type)
				for id in stat_list:
					stats._add(id, StatInfo.new(), stat_list[id])
			
			&"zone":
				var id: StringName = dict.get(&"ID", &"")
				zones.add(id, dict)
			&"zones":
				var zone_list: Dictionary = dict.get(type)
				for id in zone_list:
					zones.add(id, zone_list[id])
			
			&"award":
				var id: StringName = dict.get(&"ID", &"")
				awards._add(id, AwardInfo.new(), dict)
			
			&"quest":
				var id: StringName = dict.get(&"ID", &"")
				var quest := QuestInfo.new()
				quests._add(id, quest)
				
				var ticks: Dictionary = UDict.pop(dict, &"ticks", {})
				var triggers: Dictionary = UDict.pop(dict, &"triggers", {})
				_init_triggers(id, quest.triggers, triggers)
				UObj.set_properties(quest, dict)
				
				for tick_id in ticks:
					var tick_data: Dictionary = ticks[tick_id]
					var tick := QuestTick.new()
					quest.ticks[tick_id] = tick
					var tick_triggers: Dictionary = UDict.pop(tick_data, &"triggers", {})
					_init_triggers(id + "#" + tick_id, tick.triggers, tick_triggers)
					UObj.set_properties(tick, tick_data)
					tick.id = tick_id
					tick.quest_id = id

func _add_cond(cond: String) -> int:
	var hindex := hash(cond)
	_script_conds[hindex] = cond
	return hindex

func _init_triggers(id: StringName, triggers: Dictionary[QuestInfo.QuestState, Array], json: Dictionary):
	for state_id in json:
		var state: QuestInfo.QuestState = QuestInfo.QuestState.keys().find(state_id) as QuestInfo.QuestState
		triggers[state] = []
		var trigger_index := 0
		for trigger_data in json[state_id]:
			var trigger := TriggerInfo.new()
			trigger.event = UDict.pop(trigger_data, &"event", &"")
			trigger.state.assign(UDict.pop(trigger_data, &"state", {}))
			trigger.condition = _add_cond(UDict.pop(trigger_data, &"cond", ""))
			UObj.set_properties(trigger, trigger_data)
			triggers[state].append(trigger)
			
			var path := data_dir.path_join("_dbg-%s-%s-%s" % [ id, state_id, trigger_index])
			var flow_script := FlowScript.new()
			flow_script.code = trigger_data.flow
			print_rich("[color=cyan]" + flow_script.code)
			trigger.flow_script = flow_script
			flow_script.collect_expressions(_script_conds, _script_exprs)
			ResourceSaver.save(flow_script, path + ".tres")
			
			var player := FlowPlayerGenerator.generate([load(path + ".tres")])
			var packed := PackedScene.new()
			packed.pack(player)
			ResourceSaver.save(packed, path + ".tscn")
			trigger_index += 1
