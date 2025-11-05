@tool
class_name CinemaScript extends Resource

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code := ""

func get_id() -> String:
	return resource_path.get_basename().get_file()

@export_tool_button("Print Parsed") var _tb_print_parsed := func():
	var parsed := CinemaScriptParser.parse(code, resource_path)
	print(JSON.stringify(parsed, "\t", false))

@export_tool_button("Generate Dummy") var _tb_generate_dummy := func():
	CinematicGenerator.gen([self])
