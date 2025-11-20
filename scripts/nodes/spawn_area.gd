class_name SpawnArea extends Area3D

func find_position() -> Variant:
	for child in get_children():
		if child is CollisionShape3D:
			pass
	return null
