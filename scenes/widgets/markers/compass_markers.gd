extends MarkersWidget

func get_marker_asset() -> StringName:
	return &"compass_marker"

func _process(_delta: float) -> void:
	var yaw := camera.rotation.y
	var pos := camera.global_position

	var w := size.x
	var half := w * 0.5
	var fov_half := PI * 0.5 # ±90 degrees
	
	var pawn_pos := get_pawn().global_position
	
	for marker in markers:
		var marker_2d := markers[marker]
		var dir := marker.global_position - pos
		var marker_angle := atan2(dir.x, -dir.z)
		var diff := wrapf(marker_angle - yaw, -PI, PI)
		#if abs(diff) > fov_half:
			#marker_2d.visible = false
			#continue
		#marker_2d.visible = true
		var dist := marker.global_position.distance_to(pawn_pos)
		marker_2d.text = "%.1f m" % dist
		
		var x := (diff / fov_half) * half + half
		x = clamp(x, 0.0, w)
		marker_2d.position.x = x
		marker_2d.position.y = 32
	
	queue_redraw()

func _draw() -> void:
	var font := ThemeDB.fallback_font
	var fsize := ThemeDB.fallback_font_size
	
	var index := 0
	for c in "NESW":
		var x := _ang_to_x(index / 4.0 * TAU)
		var text_w := font.get_string_size(c, fsize).x
		var pos := Vector2(x - text_w * 0.5, fsize)
		draw_string(font, pos, c, HORIZONTAL_ALIGNMENT_CENTER, -1, fsize, Color.WHITE)
		index += 1
	
	for i in 4:
		var x := _ang_to_x((i + 0.5) / 4.0 * TAU)
		draw_line(Vector2(x, fsize * 0.3), Vector2(x, fsize * 0.8), Color.RED, 4.0)
	
	for i in 8:
		var x := _ang_to_x((i + 0.5) / 8.0 * TAU)
		draw_line(Vector2(x, fsize * 0.5), Vector2(x, fsize * 0.8), Color.GREEN, 2.0)

func _draw_angle_marker(ang: float, yaw: float, half: float, fov_half: float, w: float, drawer):
	var diff := wrapf(ang - yaw, -PI, PI)
	if abs(diff) > fov_half:
		return

	var x := (diff / fov_half) * half + half
	x = clamp(x, 0, w)
	drawer.call(x)

func _ang_to_x(ang: float) -> float:
	var diff := wrapf(ang - camera.rotation.y, -PI, PI)
	var w := size.x
	var half := size.x * .5
	var fov_half := PI * 0.5
	#if abs(diff) > fov_half:
		#return
	var x := (diff / fov_half) * half + half
	x = clamp(x, 0, w)
	return x
