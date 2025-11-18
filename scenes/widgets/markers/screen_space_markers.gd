extends MarkersWidget

func get_marker_asset() -> StringName:
	return &"screen_space_marker"

func _process(_delta: float) -> void:
	var screen_size := get_controller().viewport.size
	var screen_center := screen_size * 0.5
	var camera_transform := camera.global_transform
	var camera_basis := camera_transform.basis
	var camera_origin := camera_transform.origin
	var camera_forward := -camera_basis.z
	
	for marker in markers:
		var marker_2d := markers[marker]
		var world_pos := marker.global_position
		var to_target := world_pos - camera_origin
		var dot := camera_forward.dot(to_target)
		
		var screen_pos: Vector2
		
		if dot > 0.0:
			# In front of camera.
			screen_pos = camera.unproject_position(world_pos)
			
			if not marker_2d.is_in_view():
				marker_2d.enter_view()
		else:
			# Behind camera — mirror point across camera.
			var mirrored_pos := camera_origin - to_target
			screen_pos = camera.unproject_position(mirrored_pos)
			
			# Move to edge: center screen + vector toward projected point.
			var dir := (screen_pos - screen_center).normalized()
			screen_pos = screen_center + dir * (screen_size.length() * 0.5)
			
			if marker_2d.is_in_view():
				marker_2d.exit_view()
		
		if marker is Marker:
			screen_pos += marker.offset
			marker_2d.modulate = marker.color
			match marker.label_style:
				Marker.LabelStyle.DISTANCE:
					var dist := world_pos.distance_to(camera_origin)
					marker_2d.set_text("%.1fm" % [dist])
				Marker.LabelStyle.NAME:
					marker_2d.set_text(marker.name)
				Marker.LabelStyle.TEXT:
					marker_2d.set_text(marker.text)
		# Offset based on origin.
		screen_pos -= marker_2d.size * .5
		# Clamp final 2D position to screen edges with margin.
		screen_pos.x = clampf(screen_pos.x, 0.0, screen_size.x - marker_2d.size.x)
		screen_pos.y = clampf(screen_pos.y, 0.0, screen_size.y - marker_2d.size.y)
		
		marker_2d.position = screen_pos
