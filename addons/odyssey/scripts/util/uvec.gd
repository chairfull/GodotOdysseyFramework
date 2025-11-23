class_name UVec extends RefCounted

static func lerp_rotation(a: Vector3, b: Vector3, weight: float) -> Vector3:
	return Vector3(
		lerp_angle(a.x, b.x, weight),
		lerp_angle(a.y, b.y, weight),
		lerp_angle(a.z, b.z, weight))
