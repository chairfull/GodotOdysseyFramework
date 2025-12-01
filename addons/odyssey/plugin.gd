@tool
extends EditorPlugin

const AUTOLOADS: PackedStringArray = ["Global", "Assets", "World", "Cheats", "Cinema", "Audio", "Music", "Controllers", "Mods", "Persistent", "SaveLoad"]
var editor_screen: Node

func _enable_plugin() -> void:
	for autoload in AUTOLOADS:
		add_autoload_singleton(autoload, "scripts/autoloads/%s.gd" % autoload.to_snake_case())

func _disable_plugin() -> void:
	for autoload in AUTOLOADS:
		remove_autoload_singleton(autoload)

func _enter_tree() -> void:
	_add_property("obsidian/vault_path", "", PROPERTY_HINT_DIR)
	_add_property("obsidian/auto_tag", [], PROPERTY_HINT_ARRAY_TYPE, "String")
	
	editor_screen = preload("res://addons/odyssey/editor/odyssey_editor.tscn").instantiate()
	EditorInterface.get_editor_main_screen().add_child(editor_screen)
	_make_visible(false)

func _exit_tree() -> void:
	EditorInterface.get_editor_main_screen().remove_child(editor_screen)
	editor_screen.queue_free()

func _has_main_screen() -> bool:
	return true

func _make_visible(visible: bool) -> void:
	if editor_screen:
		editor_screen.visible = visible

func _get_plugin_name() -> String:
	return "Odyssey"

func _add_property(prop: String, default: Variant, hint := PROPERTY_HINT_NONE, hint_string := "") -> void:
	var full_path := "odyssey".path_join(prop)
	if ProjectSettings.has_setting(full_path):
		return
	ProjectSettings.set_setting(full_path, default)
	ProjectSettings.set_initial_value(full_path, default)
	ProjectSettings.add_property_info({ name=full_path, type=typeof(default), hint=hint, hint_string=hint_string })
