class_name ZoneDB extends Database

var _astar: AStar3D ## For finding routes.
var _astar_index_to_id: Dictionary[int, StringName]
var _astar_id_to_index: Dictionary[StringName, int]

func get_object_script() -> GDScript:
	return ZoneInfo

func add(id: StringName, data := {}):
	_add_nested([id], data)

func _add_nested(stack: Array, data) -> ZoneInfo:
	var id := "#".join(stack)
	var zone := ZoneInfo.new()
	_add(id, zone) 
	for prop in data:
		if prop == &"zones":
			for subzone_id in data.zones:
				var subzone_data: Dictionary = data.zones[subzone_id]
				var subzone := _add_nested([id, subzone_id], subzone_data)
				subzone.parent = zone
		elif prop in zone:
			zone[prop] = data[prop]
	return zone

func reload_astar():
	_astar = AStar3D.new()
	
	var index := 0
	for zid in _objects.keys():
		_astar.add_point(index, Vector3.ZERO)
		_astar_id_to_index[zid] = index
		_astar_index_to_id[index] = zid
		index += 1
	
	for loc: ZoneInfo in _objects.values():
		for obj in loc.objects.values():
			if obj is ZoneLink:
				var from_index: int = _astar_id_to_index.get(loc.id + "#" + obj.from_zone_id, -1)
				var to_index: int = _astar_id_to_index.get(loc.id + "#" + obj.to_zone_id, -1)
				if from_index != -1 and to_index != -1:
					_astar.connect_points(from_index, to_index)

# Tries to find a route between two zones.
static func get_route(a: ZoneInfo, b: ZoneInfo) -> Array[ZoneInfo]:
	return State.locations._get_route(a, b)

func _get_route(a: ZoneInfo, b: ZoneInfo) -> Array[ZoneInfo]:
	var path: Array[ZoneInfo]
	var a_id := _astar_id_to_index[a.id]
	var b_id := _astar_id_to_index[b.id]
	var id_path := _astar.get_id_path(a_id, b_id, false)
	for index in id_path:
		path.append(_objects[_astar_index_to_id[index]])
	return path
