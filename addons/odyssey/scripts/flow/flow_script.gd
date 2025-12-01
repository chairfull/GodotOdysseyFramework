@tool
class_name FlowScript extends Resource

enum Type { SCRIPT, SCRIPT_MOD, MENU_CHOICE }
enum ModMode {
	REPLACE, ## Replace script.
	BEFORE, ## Play before script.
	AFTER ## Play after script.
}

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code := ""
@export var type := Type.SCRIPT
@export_group("Menu", "menu_")
@export var menu_id: StringName
@export var menu_text: String ## Text shown in the menu.
@export var menu_condition: String ## Condition that must be true to show.
@export var menu_rank := 0 ## Used when sorting options.
@export var menu_icon := "" ## Icon to show.
@export var menu_tags: Array[StringName]
@export_group("Mod", "mod_")
@export var mod_script_id: StringName
@export var mod_mode := ModMode.REPLACE

func get_id() -> String:
	return resource_path.get_basename().get_file()

func get_parsed() -> Dictionary:
	return FlowScriptParser.parse(code, resource_path)

@export_tool_button("Print Parsed") var _tb_print_parsed := func():
	print(JSON.stringify(get_parsed(), "\t", false))

@export_tool_button("Print YAMLized") var _to_print_yamlized := func():
	print(YAML.stringify(get_parsed()).get_data())

@export_tool_button("Generate Dummy") var _tb_generate_dummy := func():
	FlowPlayerGenerator.generate([self])

func collect_expressions(conds: Dictionary[int, String], exprs: Dictionary[int, String]) -> void:
	var parsed := get_parsed()
	for step in parsed.tabbed:
		if step.type == FlowToken.CMND:
			match step.cmnd:
				&"CODE": exprs[hash(step.rest)] = step.rest
				&"IF": conds[hash(step.rest)] = step.rest
				&"ELIF": conds[hash(step.rest)] = step.rest
				&"ELSE": conds[hash("true")] = "true"
