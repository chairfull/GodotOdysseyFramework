class_name GeoJSON extends RefCounted

const METERS_RADIUS := 6371000.0

class Geometry extends Resource:
	func get_bbox() -> Rect2:
		return Rect2()
	
	func get_type_name() -> StringName:
		return &"Geometry"
	
	func _get_iterator_items() -> Array:
		return []
	
	func _iter_init(iter: Array) -> bool:
		iter[0] = 0
		return iter[0] < _get_iterator_items().size()
		
	func _iter_next(iter: Array) -> bool:
		iter[0] += 1
		return iter[0] < _get_iterator_items().size()
		
	func _iter_get(iter: Variant) -> Variant:
		return _get_iterator_items()[iter]

class Point extends Geometry:
	@export var position: Vector2
	func get_bbox() -> Rect2: return Rect2(position, Vector2.ZERO)
	func get_type_name() -> StringName: return &"Point"

class LineString extends Geometry:
	@export var points: PackedVector2Array
	func get_bbox() -> Rect2:
		return GeoJSON._compute_bbox_from_points(points)
	func get_type_name() -> StringName: return &"LineString"
	func _get_iterator_items() -> Array: return points

class Polygon extends Geometry:
	@export var rings: Array[PackedVector2Array]
	func get_bbox() -> Rect2:
		if rings.is_empty(): return Rect2()
		var bbox := GeoJSON._compute_bbox_from_points(rings[0])
		for i in range(1, rings.size()):
			bbox = bbox.merge(GeoJSON._compute_bbox_from_points(rings[i]))
		return bbox
	func get_type_name() -> StringName: return &"Polygon"
	func _get_iterator_items() -> Array: return rings

class MultiPoint extends Geometry:
	@export var positions: PackedVector2Array
	func get_bbox() -> Rect2: return GeoJSON._compute_bbox_from_points(positions)
	func get_type_name() -> StringName: return &"MultiPoint"
	func _get_iterator_items() -> Array: return positions

class MultiLineString extends Geometry:
	@export var lines: Array[LineString]
	func get_bbox() -> Rect2: return GeoJSON._compute_bbox_from_bboxes(lines)
	func get_type_name() -> StringName: return &"MultiLineString"
	func _get_iterator_items() -> Array: return lines

class MultiPolygon extends Geometry:
	@export var polygons: Array[Polygon]
	func get_bbox() -> Rect2: return GeoJSON._compute_bbox_from_bboxes(polygons)
	func get_type_name() -> StringName: return &"MultiPolygon"
	func _get_iterator_items() -> Array: return polygons

class GeometryCollection extends Geometry:
	@export var geometries: Array[Geometry]
	func get_bbox() -> Rect2: return GeoJSON._compute_bbox_from_bboxes(geometries)
	func get_type_name() -> StringName: return &"GeometryCollection"
	func _get_iterator_items() -> Array: return geometries

class Feature extends Resource:
	@export var id: String
	@export var properties: Dictionary
	@export var geometry: Geometry
	func get_bbox() -> Rect2: return geometry.get_bbox()
	func get_type_name() -> StringName: return &"Feature"

class FeatureCollection extends Geometry:
	@export var features: Array[Feature]
	func _get_iterator_items() -> Array: return features
	func get_bbox() -> Rect2: return GeoJSON._compute_bbox_from_bboxes(features)
	func get_type_name() -> StringName: return &"FeatureCollection"

## Loads GeoJSON data and converts to typed Resources.
## Supports all GeoJSON types with low failure rate.
## Returns GeoJSON.FeatureCollection (or null on error).
static func from_file(path: String) -> FeatureCollection:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("[GeoJSON] Cannot open file '%s'" % path)
		return null
	var json_text := file.get_as_text()
	file.close()
	return from_string(json_text)

static func from_string(json_text: String) -> FeatureCollection:
	var json := JSON.new()
	var err := json.parse(json_text)
	if err != OK:
		push_error("[GeoJSON] JSON parse error at line %d: %s" % [json.get_error_line(), json.get_error_message()])
		return null
	
	var data: Dictionary = json.data
	if data.is_empty():
		push_error("[GeoJSON] Empty or invalid JSON")
		return null
	
	var type_str: String = data.get("type", "").to_lower()
	match type_str:
		"featurecollection":
			return _parse_feature_collection(data)
		"feature":
			var feature = _parse_feature(data)
			if feature == null:
				return null
			var collection := FeatureCollection.new()
			collection.features = [feature]
			return collection
		"point", "linestring", "polygon", "multipoint", "multilinestring", "multipolygon", "geometrycollection":
			var geom = _parse_geometry(data)
			if geom == null:
				return null
			var feature := Feature.new()
			feature.geometry = geom
			feature.properties = data.get("properties", {})
			feature.id = data.get("id", "")
			var collection := FeatureCollection.new()
			collection.features = [feature]
			return collection
		_:
			push_error("?HMM")
	return null

static func _parse_feature_collection(fc: Dictionary) -> FeatureCollection:
	var collection = FeatureCollection.new()
	var features_raw: Array = fc.get("features", [])
	var features_parsed: Array[Feature]
	
	for f_raw in features_raw:
		var f_parsed = _parse_feature(f_raw)
		if f_parsed != null:
			features_parsed.append(f_parsed)
	
	collection.features = features_parsed
	return collection

static func _parse_feature(feat_raw: Dictionary) -> Feature:
	var feature := Feature.new()
	feature.id = feat_raw.get("id", "")
	feature.properties = feat_raw.get("properties", {}).duplicate(true)
	
	var geometry_raw = feat_raw.get("geometry")
	if geometry_raw == null:
		feature.geometry = null
		return feature
	
	var geometry_parsed := _parse_geometry(geometry_raw)
	if geometry_parsed == null and not _is_valid_geometry_raw(geometry_raw):
		return null
	
	feature.geometry = geometry_parsed
	return feature

static func _parse_geometry(geo_raw: Dictionary) -> Geometry:
	var type_str: String = geo_raw.get("type", "").to_lower()
	match type_str:
		"point": return _parse_point(geo_raw)
		"multipoint": return _parse_multi_point(geo_raw)
		"linestring": return _parse_line_string(geo_raw)
		"multilinestring": return _parse_multi_line_string(geo_raw)
		"polygon": return _parse_polygon(geo_raw)
		"multipolygon": return _parse_multi_polygon(geo_raw)
		"geometrycollection": return _parse_geometry_collection(geo_raw)
	return null

static func _is_valid_geometry_raw(geo: Dictionary) -> bool:
	return _parse_geometry(geo) != null

static func _parse_point(geo: Dictionary) -> Point:
	var coords_raw: Array = geo.get("coordinates", [])
	var point := Point.new()
	if not coords_raw is Array or coords_raw.size() < 2:
		point.position = Vector2.ZERO
	else:
		point.position = _coord_to_vec2(coords_raw)
	return point

static func _parse_multi_point(geo: Dictionary) -> MultiPoint:
	var coords_raw: Array = geo.get("coordinates", [])
	var positions := _parse_positions(coords_raw)
	var multi_point := MultiPoint.new()
	multi_point.positions = positions
	return multi_point

static func _parse_line_string(geo: Dictionary) -> LineString:
	var coords_raw: Array = geo.get("coordinates", [])
	var positions := _parse_positions(coords_raw)
	var line_string := LineString.new()
	line_string.points = positions
	return line_string

static func _parse_multi_line_string(geo: Dictionary) -> MultiLineString:
	var coords_raw: Array = geo.get("coordinates", [])
	var multi_line_string := MultiLineString.new()
	
	for line_coords_raw in coords_raw:
		var line = _parse_positions(line_coords_raw)
		if line.size() >= 2:
			multi_line_string.lines.append(line)
	
	return multi_line_string

static func _parse_polygon(geo: Dictionary) -> Polygon:
	var coords_raw: Array = geo.get("coordinates", [])
	var rings: Array[PackedVector2Array]
	for ring_coords_raw in coords_raw:
		var ring = _parse_positions(ring_coords_raw)
		if ring.size() >= 3:
			# Close ring if not closed
			if ring[0] != ring[ring.size() - 1]:
				ring.append(ring[0])
			rings.append(ring)
	var polygon := Polygon.new()
	polygon.rings = rings
	return polygon

static func _parse_multi_polygon(geo: Dictionary) -> MultiPolygon:
	var multi_polygon := MultiPolygon.new()
	var coords_raw: Array = geo.get("coordinates", [])
	var polygons: Array[Polygon] = []
	
	for poly_coords_raw in coords_raw:
		var poly_dict = {"coordinates": poly_coords_raw, "type": "Polygon"}
		var poly = _parse_polygon(poly_dict)
		if poly != null:
			polygons.append(poly)
	multi_polygon.polygons = polygons
	return multi_polygon

static func _parse_geometry_collection(geo: Dictionary) -> GeometryCollection:
	var collection := GeometryCollection.new()
	var geoms_raw: Array = geo.get("geometries", [])
	var geoms_parsed: Array[Geometry]
	
	for g_raw in geoms_raw:
		var g_parsed = _parse_geometry(g_raw)
		if g_parsed != null:
			geoms_parsed.append(g_parsed)
	
	collection.geometries = geoms_parsed
	return collection

static func _parse_positions(coords_raw: Array) -> PackedVector2Array:
	var points := PackedVector2Array()
	for coord_raw in coords_raw:
		if coord_raw is Array:
			var pt = _coord_to_vec2(coord_raw)
			if pt != Vector2.ZERO or coord_raw.size() == 0:  # Allow explicit [0,0]
				points.append(pt)
	return points

static func _coord_to_vec2(coord_raw: Array) -> Vector2:
	if coord_raw.size() >= 2 and coord_raw[0] is float and coord_raw[1] is float:
		return Vector2(coord_raw[0], coord_raw[1])
	push_warning("[GeoJSON] Invalid coordinate skipped: %s" % str(coord_raw))
	return Vector2.ZERO

static func _parse_bbox(bbox_raw: Array) -> Rect2:
	if bbox_raw.size() == 4 and \
	   bbox_raw[0] is float and bbox_raw[1] is float and \
	   bbox_raw[2] is float and bbox_raw[3] is float:
		return Rect2(bbox_raw[0], bbox_raw[1], bbox_raw[2] - bbox_raw[0], bbox_raw[3] - bbox_raw[1])
	return Rect2()

static func _compute_bbox_from_bboxes(geoms: Array) -> Rect2:
	if geoms.is_empty():
		return Rect2()
	var bbox: Rect2 = geoms[0].get_bbox()
	for i in range(1, geoms.size()):
		bbox = bbox.merge(geoms[i].get_bbox())
	return bbox

static func _compute_bbox_from_points(points: PackedVector2Array) -> Rect2:
	if points.is_empty():
		return Rect2()
	var min_x = points[0].x
	var min_y = points[0].y
	var max_x = min_x
	var max_y = min_y
	for pt in points:
		min_x = min(min_x, pt.x)
		min_y = min(min_y, pt.y)
		max_x = max(max_x, pt.x)
		max_y = max(max_y, pt.y)
	return Rect2(min_x, min_y, max_x - min_x, max_y - min_y)

static func lonlat_to_vec3(lonlat: Vector2) -> Vector3:
	var lon := deg_to_rad(lonlat.x)
	var lat := deg_to_rad(lonlat.y)
	var x := cos(lat) * cos(lon)
	var y := sin(lat)
	var z := cos(lat) * sin(lon)
	return Vector3(x, y, -z)

static func vec3_to_lonlat(pos: Vector3) -> Vector2:
	var r := float(pos.length())
	var lat := asin(pos.y / r)
	var lon := atan2(-pos.z, pos.x)
	return Vector2(rad_to_deg(lon), rad_to_deg(lat))

static func lonlat_to_meters(lonlat: Vector2, lat0: float = 0.0, radius: float = METERS_RADIUS) -> Vector2:
	# lat0 = reference latitude in degrees (for longitude scaling)
	var lat_rad := deg_to_rad(lat0)
	var x := deg_to_rad(lonlat.x) * radius * cos(lat_rad)  # meters east
	var y := deg_to_rad(lonlat.y) * radius                 # meters north
	return Vector2(x, y)

static func meters_to_lonlat(pos_m: Vector2, lat0: float = 0.0, radius: float = METERS_RADIUS) -> Vector2:
	# pos_m.x = meters east, pos_m.y = meters north
	var lat_deg = rad_to_deg(pos_m.y / radius)
	var lon_deg = rad_to_deg(pos_m.x / (radius * cos(deg_to_rad(lat0))))
	return Vector2(lon_deg, lat_deg)

static func ray_sphere_intersect(ray_position: Vector3, ray_normal: Vector3, sphere_position: Vector3, sphere_radius := 1.0) -> Vector3:
	var dir := ray_position - sphere_position
	var a := ray_normal.dot(ray_normal)
	var b := 2 * ray_normal.dot(dir)
	var c := dir.dot(dir) - sphere_radius * sphere_radius
	var disc := b*b - 4*a*c
	if disc < 0:
		return ray_position  # no intersection
	var sqrt_disc := sqrt(disc)
	var t0 := (-b - sqrt_disc) / (2*a)
	var t1 := (-b + sqrt_disc) / (2*a)
	var t = minf(t0, t1)
	if t < 0:
		t = maxf(t0, t1)  # behind ray?
		if t < 0:
			return ray_position
	return ray_position + ray_normal * t
