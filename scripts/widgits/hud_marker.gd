class_name HUDMarker extends Control
## 2D position for a 3D node.

signal entered_view()
signal exited_view()

@export var target: Marker ## Object being tracked.
@export var origin := Vector2(0.5, 1.0) ## Multiplied by size.
var camera: Camera3D
var viewport: SubViewport
var _inview := false

func _process(_delta: float) -> void:
	if not target: return
	var screen_size := viewport.get_visible_rect().size
	var camera_transform := camera.global_transform
	var camera_basis := camera_transform.basis
	var camera_origin := camera_transform.origin
	var world_pos := target.global_position
	var to_target := world_pos - camera_origin
	var camera_forward := -camera_basis.z
	var dot := camera_forward.dot(to_target)
	
	var dist := world_pos.distance_to(camera_origin)
	%label.text = "%sm" % [int(dist)]
	
	if dot > 0.0:
		# In front of camera.
		position = camera.unproject_position(world_pos)
		
		if not _inview:
			_inview = true
			entered_view.emit()
	else:
		# Behind camera — mirror point across camera.
		var mirrored_pos := camera_origin - to_target
		position = camera.unproject_position(mirrored_pos)
		
		# Move to edge: center screen + vector toward projected point.
		var screen_center := screen_size * 0.5
		var dir := (position - screen_center).normalized()
		position = screen_center + dir * (screen_size.length() * 0.5)
		
		if _inview:
			_inview = false
			exited_view.emit()
	
	# Offset based on origin.
	position -= size * origin
	# Clamp final 2D position to screen edges with margin.
	position.x = clampf(position.x, 0.0, screen_size.x - size.x)
	position.y = clampf(position.y, 0.0, screen_size.y - size.y)
