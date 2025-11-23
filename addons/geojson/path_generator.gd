@tool
extends Node

@export var point_target: Node
@export_file_path("*.json") var file: String
@export_tool_button("Regen") var _tb_regen := regenerate

func regenerate() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	var json := FileAccess.get_file_as_string(file)
	var data := JSON.parse_string(json)
	for link in data.links:
		var from := point_target.get_node_or_null(link.from)
		var to := point_target.get_node_or_null(link.to)
		if not from or not to:
			print("Couldn't find %s. %s %s" % [link, from, to])
			continue
		var path := Line2D.new()
		add_child(path)
		path.name = "%s to %s" % [from.name, to.name]
		path.owner = owner
		path.points = [from.position, to.position]
