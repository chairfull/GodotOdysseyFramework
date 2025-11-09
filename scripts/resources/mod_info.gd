@tool
class_name ModInfo extends StateObjects

@export var mod_name := "Unnamed Mod"
@export var mod_author := "Author"
@export var mod_version := "0.0.1"
@export_global_dir var data_dir: String: ## Directory to scan for data files.
	get: return data_dir if data_dir else resource_path.get_base_dir()
@export_multiline var _debug_info := ""
@export var _script_conds: Dictionary[StringName, String]
@export var _script_exprs: Dictionary[StringName, String]

@warning_ignore("unused_private_class_variable")
@export_tool_button("Regen") var _tb_regen := func():
	clear()
	_script_conds.clear()
	_script_exprs.clear()
	
	_scan_dir(data_dir)
	_debug_info = get_counts_string("\n")
	
	# Resave to disk.
	ResourceSaver.save(self, resource_path)
	
func _scan_dir(dir: String):
	for subdir in DirAccess.get_directories_at(dir):
		_scan_dir(dir.path_join(subdir))
	for file in DirAccess.get_files_at(dir):
		var path := dir.path_join(file)
		match file.get_extension():
			"json": _load_json(path)
			"yaml": _load_yaml(path)

func _load_yaml(file: String):
	var yaml_str := FileAccess.get_file_as_string(file)
	var yaml_result := YAML.parse(yaml_str)
	if yaml_result.has_error():
		push_error(yaml_result.get_error())
		return
	var data: Variant = yaml_result.get_data()
	_load_data(data)

func _load_json(file: String):
	var json := FileAccess.get_file_as_string(file)
	var data: Variant = JSON.parse_string(json)
	_load_data(data)

func _process_flow(flow_script: FlowScript):
	var parsed := flow_script.get_parsed()
	for step in parsed.tabbed:
		if step.type == FlowToken.CMND:
			match step.cmnd:
				&"CODE": _add_expr(step.rest)
				&"IF": _add_cond(step.rest)
				&"ELIF": _add_cond(step.rest)
				&"ELSE": _add_cond("true")

func _add_cond(st: String) -> StringName:
	var meth_name := StringName("_cond_%s" % hash(st))
	_script_conds[meth_name] = st
	return meth_name

func _add_expr(st: String) -> StringName:
	var meth_name := StringName("_expr_%s" % hash(st))
	_script_exprs[meth_name] = st
	return meth_name

func _load_data(data: Variant):
	if data is Dictionary: data = [data]
	for dict: Dictionary in data:
		var type: StringName = dict.get(&"TYPE", &"")
		match type:
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
			
			&"zone":
				var id: StringName = dict.get(&"ID", &"")
				zones.add(id, dict)
			&"zones":
				var zone_list: Dictionary = dict.get(type)
				for id in zone_list:
					zones.add(id, zone_list[id])
				
			&"quest":
				var id: StringName = dict.get(&"ID", &"")
				var quest := QuestInfo.new()
				var tick_data: Dictionary = UDict.pop(dict, &"ticks", {})
				var triggers: Dictionary = UDict.pop(dict, &"triggers", {})
				UObj.set_properties(quest, dict)
				for tick_id in tick_data:
					var tick := QuestTick.new()
					UObj.set_properties(tick, tick_data[tick_id])
					tick.id = tick_id
					tick.quest_id = id
					quest.ticks[tick_id] = tick
				for state_id in triggers:
					var state: QuestInfo.QuestState = QuestInfo.QuestState.keys().find(state_id) as QuestInfo.QuestState
					quest.triggers[state] = []
					var trigger_index := 0
					for trigger_data in triggers[state_id]:
						var trigger := TriggerInfo.new()
						trigger.event = UDict.pop(trigger_data, &"event", &"")
						trigger.state.assign(UDict.pop(trigger_data, &"state", {}))
						trigger.condition = _add_cond(UDict.pop(trigger_data, &"cond", ""))
						UObj.set_properties(trigger, trigger_data)
						quest.triggers[state].append(trigger)
						
						var path := data_dir.path_join("_dbg-%s-%s-%s" % [ id, state_id, trigger_index])
						var flow_script := FlowScript.new()
						flow_script.code = trigger_data.flow
						print_rich("[color=cyan]" + flow_script.code)
						trigger.flow_script = flow_script
						_process_flow(flow_script)
						ResourceSaver.save(flow_script, path + ".tres")
						
						var player := FlowPlayerGenerator.generate([load(path + ".tres")])
						var packed := PackedScene.new()
						packed.pack(player)
						ResourceSaver.save(packed, path + ".tscn")
						trigger_index += 1
						
				quests._add(id, quest)
