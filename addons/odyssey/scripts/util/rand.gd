class_name Rand extends RefCounted

static func point_on_sphere() -> Vector3:
	var u := randf() * TAU
	var v := randf() * TAU
	var z := randf() * 2.0 - 1.0
	var r := sqrt(1.0 - z * z)
	return Vector3(r * cos(u) * sin(v), r * sin(u) * sin(v), z * cos(v)).normalized()

static func point_on_circle() -> Vector2:
	var rad := randf() * TAU
	return Vector2(cos(rad), sin(rad))
