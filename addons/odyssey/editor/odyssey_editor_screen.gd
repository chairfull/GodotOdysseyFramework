@tool
extends Node

var tags_enabled: Array[StringName]
var files: Array[TreeItem]
var folders: Dictionary[StringName, TreeItem]

func _ready() -> void:
	%update_db.pressed.connect(_refresh)
	%tree.item_selected.connect(_tree_item_selected)

func _tree_item_selected() -> void:
	var sel: TreeItem = %tree.get_selected()
	if sel.has_meta(&"file"):
		var file: ObsidianFile = sel.get_meta(&"file")
		%markdown_preview.text = Markdown.to_bbcode(file.elements)
	else:
		%markdown_preview.text = "Section: " + sel.get_text(0)

func _toggle_tag(tag: String) -> void:
	if tag in tags_enabled:
		tags_enabled.erase(tag)
	else:
		tags_enabled.append(tag)
	
	for child in %tags.get_children():
		if child.name in tags_enabled:
			child.modulate = Color.WHITE
		else:
			child.modulate = Color(Color.WHITE, 0.2)
	
	for item in files:
		var file: ObsidianFile = item.get_meta(&"file")
		var show := false
		for tg in tags_enabled:
			if tg in file.tags:
				show = true
				break
		item.visible = show
	
	for item: TreeItem in folders.values():
		var show := false
		for ch in item.get_children():
			if ch.visible:
				show = true
				break
		item.visible = show

func _refresh() -> void:
	files.clear()
	folders.clear()
	
	ObsidianDB.regenerate()
	var db := ObsidianDB.ref
	
	UNode.remove_children(%tags)
	for tag in db.tags:
		var btn := Button.new()
		btn.text = tag
		btn.name = tag
		btn.pressed.connect(_toggle_tag.bind(tag))
		%tags.add_child(btn)
	
	var tree: Tree = %tree
	tree.clear()
	var tree_root := tree.create_item()
	tree.hide_root = true
	
	for id in db.files:
		var file := db.files[id]
		var parent: TreeItem = null
		var text := ""
		if "/" in id:
			var parts := id.rsplit("/", true, 1)
			var par_path := parts[0]
			if not par_path in folders:
				var tree_item := tree.create_item()
				tree_item.set_text(0, par_path)
				folders[par_path] = tree_item
			text = parts[-1]
			parent = folders[par_path]
		else:
			text = id
			parent = tree_root
		var titem := tree.create_item(parent)
		titem.set_meta(&"file", file)
		titem.set_text(0, text)
		files.append(titem)
