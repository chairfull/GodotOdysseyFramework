@tool
extends EditorPlugin

var inspector_plugin := TweeInspector.new()# preload("twee_inspector.gd").new()
const Tokenizer := preload("builder/twee_tokenizer.gd")

func _enter_tree():
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

class TweeInspector extends EditorInspectorPlugin:
	func _can_handle(object: Object) -> bool:
		return object is TweeNode

	func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
		if object is TweeNode and name.begins_with("_TWEE_"):
			var hl := CodeHighlighter.new()
			var settings := EditorInterface.get_editor_settings()
			for b in [
				"Color", "Vector2", "Vector3", "Transform2D", "Transform3D", "Basis", "Quaternion",
				"Node", "Node2D", "Node3D", "Object", "Resource", "Dictionary", "Array", "PackedStringArray" ]:
				hl.add_keyword_color(b, settings.get("text_editor/theme/highlighting/user_type_color"))
			
			var node_color = settings.get("text_editor/theme/highlighting/gdscript/node_path_color")
			#var props := 0
			#for prop in object.get_property_list():
				#if prop.usage & PROPERTY_USAGE_DEFAULT:
					#hl.add_keyword_color(prop.name, Color.PALE_VIOLET_RED)
					#props += 1
			
			var trans_color =  Color.AQUAMARINE #settings.get("text_editor/theme/highlighting/comment_markers/critical_color")
			for key in ["L", "LINEAR", "EASE", "E", "EASE_IN", "EI", "EASE_OUT", "EO",
				"E_BACK", "EI_BACK", "EO_BACK", "EOI_BACK"]:
				hl.add_keyword_color(key, trans_color)
			
			#for prop in object.get_signal_list():
				#hl.add_keyword_color(prop.name, Color.PALE_VIOLET_RED)
			
			hl.number_color = settings.get("text_editor/theme/highlighting/number_color")
			hl.symbol_color = settings.get("text_editor/theme/highlighting/symbol_color")
			hl.function_color = settings.get("text_editor/theme/highlighting/function_color")
			hl.member_variable_color = settings.get("text_editor/theme/highlighting/member_variable_color")
			hl.add_color_region("\"", "\"", settings.get("text_editor/theme/highlighting/string_color"))
			hl.add_color_region("'", "'", settings.get("text_editor/theme/highlighting/string_color"))
			var bool_color = settings.get("text_editor/theme/highlighting/keyword_color")
			hl.add_keyword_color("true", bool_color)
			hl.add_keyword_color("false", bool_color)
			var builtin_color = Color.PALE_GOLDENROD#settings.get("text_editor/theme/highlighting/gdscript/annotation_color")
			for prop in ["ON", "PARALLEL", "BLOCK", "LOOP", "FOR", "CHILD", "GROUP", "FIND", "PROP"]:
				hl.add_keyword_color(prop, builtin_color)
			hl.add_color_region("#", "", settings.get("text_editor/theme/highlighting/comment_color"), true)
			
			var vbox := VBoxContainer.new()
			vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			var hbox := HBoxContainer.new()
			vbox.add_child(hbox)
			hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			for btn_dat in [
				["Tokens", func(): Twee.prnt_tokens(object[name]), "Print tokens to output."],
				["Parsed", func(): Twee.prnt_parsed(object[name]), "Print parser to output."],
				["Source", func(): Twee.prnt_source_code(object[name]), "Print source_code to output."],
				["Run", func(): pass, "Not Implemented..."],
				["End", func(): pass, "Not Implemented..."]
				]:
				var btn := Button.new()
				hbox.add_child(btn)
				btn.text = btn_dat[0]
				btn.pressed.connect(btn_dat[1])
				btn.tooltip_text = btn_dat[2]
				btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			
			var editor := CodeEdit.new()
			vbox.add_child(editor)
			editor.gutters_draw_line_numbers = true
			editor.text = object.get(name)
			editor.syntax_highlighter = hl
			editor.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			editor.highlight_current_line = true
			editor.highlight_all_occurrences = true
			editor.text_changed.connect(func(): object.set(name, editor.text))
			editor.custom_minimum_size.y = 300.0
			add_property_editor(name, vbox)
			return true
		return false
