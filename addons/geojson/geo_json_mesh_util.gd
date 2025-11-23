class_name GeoJSONMeshUtil extends RefCounted

static func add_polygon(st: SurfaceTool, points: PackedVector2Array, vec2tovec3: Callable) -> void:
	if points.size() < 3:
		return
	var indices: PackedInt32Array = Geometry2D.triangulate_polygon(points)
	if indices.is_empty():
		return
	var clr := Color.DEEP_SKY_BLUE
	clr.ok_hsl_h = randf_range(-PI, PI)
	for t in range(0, indices.size(), 3):
		var a := vec2tovec3.call(points[indices[t+2]])
		var b := vec2tovec3.call(points[indices[t+1]])
		var c := vec2tovec3.call(points[indices[t]])
		st.set_color(clr); st.add_vertex(a)
		st.set_color(clr); st.add_vertex(b)
		st.set_color(clr); st.add_vertex(c)

static func add_linestring(st: SurfaceTool, points: PackedVector2Array, vec2tovec3: Callable) -> void:
	if points.size() < 2:
		return
	for i in range(points.size() - 1):
		var a: Vector3 = vec2tovec3.call(points[i])
		var b: Vector3 = vec2tovec3.call(points[i + 1])
		var seg := b - a
		if seg.length() == 0:
			continue
		var tangent := seg.normalized()
		st.set_uv(Vector2(-1, 0)); st.set_normal(tangent); st.add_vertex(a)
		st.set_uv(Vector2( 1, 0)); st.set_normal(tangent); st.add_vertex(a)
		st.set_uv(Vector2(-1, 0)); st.set_normal(tangent); st.add_vertex(b)
		# triangle 2
		st.set_uv(Vector2(-1, 0)); st.set_normal(tangent); st.add_vertex(b)
		st.set_uv(Vector2( 1, 0)); st.set_normal(tangent); st.add_vertex(a)
		st.set_uv(Vector2( 1, 0)); st.set_normal(tangent); st.add_vertex(b)

static func vec2_to_vec3(pos: Vector2) -> Vector3:
	return GeoJSON.lonlat_to_vec3(pos)# Vector3(pos.x, 0.0, pos.y)
