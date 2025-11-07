@tool
class_name FlowScript extends Resource

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code := ""

func get_id() -> String:
	return resource_path.get_basename().get_file()

func get_parsed() -> Dictionary:
	return FlowScriptParser.parse(code, resource_path)

@export_tool_button("Print Parsed") var _tb_print_parsed := func():
	print(JSON.stringify(get_parsed(), "\t", false))

@export_tool_button("Generate Dummy") var _tb_generate_dummy := func():
	FlowPlayerGenerator.generate([self])
