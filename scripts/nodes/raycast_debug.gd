@tool
extends RayCast3D

func _process(_delta: float) -> void:
	var colliding := false
	var point := global_position
	var normal := Vector3.UP
	
	if Engine.is_editor_hint():
		var cam := EditorInterface.get_editor_viewport_3d(0).get_camera_3d()
		if cam:
			var world := cam.get_world_3d().direct_space_state
			var query := PhysicsRayQueryParameters3D.create(global_position, global_position + target_position, collision_mask)
			var hit := world.intersect_ray(query)
			if hit:
				colliding = true
				point = hit.position
				normal = hit.normal
	else:
		colliding = is_colliding()
		point = get_collision_point()
		normal = get_collision_normal()
	
	if colliding:
		DebugDraw3D.draw_sphere(point, 0.05, Color.RED)
		DebugDraw3D.draw_sphere(point + normal * .1, 0.025, Color.RED)
