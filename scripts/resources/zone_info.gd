class_name ZoneInfo extends DatabaseObject

@export var objects: Dictionary[StringName, Resource]
@export var parent: ZoneInfo

func is_subzone() -> bool:
	return "#" in id

func _to_string() -> String:
	return "Zone(%s)" % [id]

func has_link(link_id: StringName) -> bool:
	return link_id in objects and objects[link_id] is ZoneLink

func get_link(link_id: StringName, silent := true) -> ZoneLink:
	if has_link(link_id):
		return objects[link_id]
	if not silent:
		push_error("No link %s in %s: " % [link_id, id], UStr.get_similar(link_id, objects.keys()))
	return null

func get_links_to(dest: ZoneInfo) -> Dictionary[StringName, ZoneLink]:
	var out: Dictionary[StringName, ZoneLink]
	for oid: StringName in objects:
		if objects[oid] is ZoneLink:
			var link: ZoneLink = objects[oid]
			if link.a == dest or link.b == dest:
				out[oid] = link
	return out

func get_links_between(a: ZoneInfo, b: ZoneInfo) -> Dictionary[StringName, ZoneLink]:
	var out: Dictionary[StringName, ZoneLink]
	for oid: StringName in objects:
		if objects[oid] is ZoneLink:
			var link: ZoneLink = objects[oid]
			if (link.a == a and link.b == b) or (link.a == b and link.b == a):
				out[oid] = link
	return out

func get_children() -> Array[ZoneInfo]:
	var out: Array[ZoneInfo]
	for loc: ZoneInfo in State.locations:
		if loc.parent == self:
			out.append(loc)
	return out
