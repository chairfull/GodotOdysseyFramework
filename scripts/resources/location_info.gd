class_name LocationInfo extends DatabaseObject

var objects: Dictionary[StringName, Resource]
var parent: LocationInfo

func get_db() -> Database: return State.locations

## Is this Zone loaded as a scene?
func is_active_scene() -> bool:
	for scene in Group.all(&"ZoneScene"):
		if scene is Location and scene.info == self:
			return true
	return false

func is_subzone() -> bool:
	return "#" in id

func _to_string() -> String:
	return "Zone(%s)" % [id]

func has_link(link_id: StringName) -> bool:
	return link_id in objects and objects[link_id] is LocationLink

func get_link(link_id: StringName, silent := true) -> LocationLink:
	if has_link(link_id):
		return objects[link_id]
	if not silent:
		push_error("No link %s in %s: " % [link_id, id], UStr.get_similar(link_id, objects.keys()))
	return null

func get_links_to(dest: LocationInfo) -> Dictionary[StringName, LocationLink]:
	var out: Dictionary[StringName, LocationLink]
	for oid: StringName in objects:
		if objects[oid] is LocationLink:
			var link: LocationLink = objects[oid]
			if link.a == dest or link.b == dest:
				out[oid] = link
	return out

func get_links_between(a: LocationInfo, b: LocationInfo) -> Dictionary[StringName, LocationLink]:
	var out: Dictionary[StringName, LocationLink]
	for oid: StringName in objects:
		if objects[oid] is LocationLink:
			var link: LocationLink = objects[oid]
			if (link.a == a and link.b == b) or (link.a == b and link.b == a):
				out[oid] = link
	return out

func get_children() -> Array[LocationInfo]:
	var out: Array[LocationInfo]
	for loc: LocationInfo in State.locations:
		if loc.parent == self:
			out.append(loc)
	return out
