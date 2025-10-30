class_name LocationDB extends Database

var _astar: AStar3D ## For finding routes.
var _astar_index_to_id: Dictionary[int, StringName]
var _astar_id_to_index: Dictionary[StringName, int]

func get_object_script() -> GDScript:
	return LocationInfo

func reload_astar():
	_astar = AStar3D.new()
	
	var index := 0
	for zid in _objects.keys():
		_astar.add_point(index, Vector3.ZERO)
		_astar_id_to_index[zid] = index
		_astar_index_to_id[index] = zid
		index += 1
	
	for loc: Location in _objects.values():
		for obj in loc.objects.values():
			if obj is LocationLink:
				var from_index: int = _astar_id_to_index.get(loc.id + "#" + obj.from_zone_id, -1)
				var to_index: int = _astar_id_to_index.get(loc.id + "#" + obj.to_zone_id, -1)
				if from_index != -1 and to_index != -1:
					_astar.connect_points(from_index, to_index)

# Tries to find a route between two zones.
static func get_route(a: LocationInfo, b: LocationInfo) -> Array[LocationInfo]:
	return State.locations._get_route(a, b)

func _get_route(a: LocationInfo, b: LocationInfo) -> Array[LocationInfo]:
	var path: Array[LocationInfo]
	var a_id := _astar_id_to_index[a.id]
	var b_id := _astar_id_to_index[b.id]
	var id_path := _astar.get_id_path(a_id, b_id, false)
	for index in id_path:
		path.append(_objects[_astar_index_to_id[index]])
	return path
