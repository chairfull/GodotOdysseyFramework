@tool
class_name GeoJSONNode extends Node

@export_file("*.json", "*.geo.json", "*.geojson") var geo_json_file_path: String:
	set(p):
		geo_json_file_path = p
		if Engine.is_editor_hint():
			regenerate()

@export_tool_button("Regenerate") var _tb_regenerate := regenerate
@export_tool_button("Clear") var _tb_clear := clear
@export var mode_3d := false
@export var map_size := Vector2(1920, 1080)
@export var name_from_property: StringName
@export var material_override: Material
@export var bbox: Rect2

func clear() -> void:
	for node in get_children():
		remove_child(node)
		node.queue_free()

func regenerate() -> void:
	clear()
	
	var features := GeoJSON.from_file(geo_json_file_path)
	if not features:
		push_error("[GeoJSON] No features.")
		return
	
	if not material_override:
		material_override = ShaderMaterial.new()
		material_override.shader = load("res://addons/geojson/geojson_line_renderer_aa.gdshader")
	
	bbox = features.get_bbox()
	
	for feature in features.features:
		var geom := feature.geometry
		var node: Node
		match geom.get_type_name():
			&"Point":
				node = _create(Node2D)
				node.position = lonlat_to_position(geom.position, map_size)
			&"MultiPoint":
				node = _create(Node2D)
				for point in geom.positions:
					var subnode := _create(Node2D, node)
					subnode.position = lonlat_to_position(geom.position, map_size)
			&"LineString":
				node = _create(Line2D)
				node.points = multi_lonlat_to_position(geom.points, map_size)
			&"MultiLineString":
				node = _create(Node2D)
				for line in geom.lines:
					var subnode := _create(Line2D, node)
					subnode.points = multi_lonlat_to_position(line.points, map_size)
			&"Polygon":
				if mode_3d:
					node = _create(MeshInstance3D)
					var st := SurfaceTool.new()
					st.begin(Mesh.PRIMITIVE_TRIANGLES)
					GeoJSONMeshUtil.add_polygon(st, geom.rings[0], map)
					node.mesh = st.commit()
					node.material_overlay = material_override
				else:
					node = _create(Polygon2D)
					node.polygon = multi_lonlat_to_position(geom.rings[0], map_size)
			&"MultiPolygon":
				if mode_3d:
					node = _create(Node3D)
					for poly in geom.polygons:
						var subnode: MeshInstance3D = _create(MeshInstance3D, node)
						var st := SurfaceTool.new()
						st.begin(Mesh.PRIMITIVE_TRIANGLES)
						GeoJSONMeshUtil.add_polygon(st, poly.rings[0], map)
						subnode.mesh = st.commit()
						subnode.material_overlay = material_override
				else:
					node = _create(Node2D)
					for poly in geom.polygons:
						var subnode := _create(Polygon2D, node)
						subnode.polygon = multi_lonlat_to_position(poly.rings[0], map_size)
					
		if node and name_from_property and name_from_property in feature.properties:
			node.name = feature.properties[name_from_property]
			
		if node:
			if node is CanvasItem:
				node.modulate = Color.DEEP_SKY_BLUE
				node.modulate.ok_hsl_h = randf_range(-PI, PI)
			node.set_display_folded(true)

func map(lonlat: Vector2) -> Vector3:
	var pos := lonlat_to_position(lonlat, map_size)
	return Vector3(pos.x, 0, pos.y)

func _create(scr: Object, parent: Node = self) -> Node:
	var node: Node = scr.new()
	parent.add_child(node)
	node.name = "feature_%s" % parent.get_child_count()
	node.owner = owner if owner else self
	#generated.append(node)
	return node

static func map_points(points: PackedVector2Array, trans: Callable) -> Array[Vector3]:
	var out: Array[Vector3]
	out.assign(Array(points).map(trans))
	return out

static func multi_lonlat_to_position(list: PackedVector2Array, map_size: Vector2) -> PackedVector2Array:
	for i in list.size():
		list[i] = lonlat_to_position(list[i], map_size)
	return list

## Single function: lat/lon -> Godot pixels (Web Mercator projection, north-up, no warp)
## Hardcoded for USA mainland (conterminous 48 states). Perfect for your 500k Census data.
## Usage: Replace coords in your GeoJSON rings/points after loading.
static func lonlat_to_position(lon_lat: Vector2, map_size: Vector2) -> Vector2:
	# Precise bbox for conterminous USA (padded slightly)
	const MIN_LON = -125.0
	const MAX_LON = -66.5
	const MIN_LAT = 25.0
	const MAX_LAT = 49.5
	
	var lon := lon_lat.x
	var lat := lon_lat.y
	
	# X: simple linear (negligible distortion over 60° lon span)
	var x = remap(lon, MIN_LON, MAX_LON, 0.0, map_size.x)
	
	# Y: Web Mercator (conformal, shapes preserved) + flipped for Godot Y-down/north-up
	var merc_min = _merc_y(MIN_LAT)
	var merc_max = _merc_y(MAX_LAT)
	var merc_this = _merc_y(lat)
	var y = remap(merc_this, merc_max, merc_min, 0.0, map_size.y)
	
	return Vector2(x, y)

static func _merc_y(lat_deg: float) -> float:
	var lat_clamped = clamp(lat_deg, -85.05112878, 85.05112878)
	var lat_rad = deg_to_rad(lat_clamped)
	return log(tan(PI / 4.0 + lat_rad / 2.0))
