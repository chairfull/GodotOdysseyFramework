extends Node

const DIR := "user://saves"

var _current_slot := "quick_save"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"quick_save"):
		save_slot()
		get_viewport().set_input_as_handled()

func get_slots_dirs() -> Array[String]:
	return DirAccess.get_directories_at(DIR)

func save_slot(slot: StringName = _current_slot):
	var dir := _get_dir(slot)
	if not DirAccess.dir_exists_absolute(dir):
		DirAccess.make_dir_recursive_absolute(dir)
	
	var preview := get_viewport().get_texture().get_image()
	preview.shrink_x2()
	preview.save_webp(dir.path_join("preview.webp"))
	
	_save_node(dir, State, "State")
	_save_node("user://", Persistent, "Persistent")
	
	print("Saved to: ", ProjectSettings.globalize_path(dir))

func _save_node(dir: String, node: Node, file: String) -> bool:
	var packed := PackedScene.new()
	var err := packed.pack(node)
	if not err == OK:
		print("PACKING: ", error_string(err))
		return false
	err = ResourceSaver.save(packed, dir.path_join(file + ".tscn"))
	if not err == OK:
		print("SAVING: ", error_string(err))
		return false
	return true

func load_slot(slot: StringName = _current_slot):
	var _dir := _get_dir(slot)
	

func _get_dir(slot: StringName = _current_slot) -> String:
	return DIR.path_join(slot)
