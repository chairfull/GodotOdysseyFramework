@tool
class_name Minimap extends Control

const SAVE_DIR := "res://assets/_debug"

@export_tool_button("Load All") var _tool_load_all := load_all_cells
@export var minimap: MinimapData

func clear_cells():
	var cell_parent := %cells
	for child in cell_parent.get_children():
		cell_parent.remove_child(child)
		child.queue_free()

func load_all_cells():
	clear_cells()
	if not minimap: return
	var dir := SAVE_DIR.path_join(minimap.scene.get_basename().get_file())
	var cell_parent := %cells
	for cell in minimap.cells:
		var cell_node := TextureRect.new()
		cell_parent.add_child(cell_node)
		cell_node.owner = self
		cell_node.name = "%s %s %s" % [cell.x, cell.y, cell.z]
		cell_node.texture = load(dir.path_join("%s_%s_%s.%s" % [cell.x, cell.y, cell.z, minimap.texture_format]))
		cell_node.position = Vector2(cell.y, cell.z) * Vector2(minimap.texture_size)
