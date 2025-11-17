class_name CompassBar extends Widget

@onready var camera := get_controller().camera_master
var markers: Dictionary[Node3D, Node2D]

func _ready() -> void:
	for node in get_tree().get_nodes_in_group(&"marker"):
		_group_added(node, &"marker")
	Global.added_to_group.connect(_group_added)
	Global.added_to_group.connect(_group_removed)

func _group_added(node: Node, id: StringName) -> void:
	if id == &"marker":
		var marker := Sprite2D.new()
		marker.texture = load("res://icon.svg")
		marker.scale = Vector2.ONE * .2
		add_child(marker)
		markers[node as Node3D] = marker

func _group_removed(node: Node, id: StringName) -> void:
	if id == &"marker":
		var marker := markers[node as Node3D]
		remove_child(marker)
		marker.queue_free()
		markers.erase(node as Node3D)

func _process(_delta: float) -> void:
	var yaw := camera.rotation.y
	var pos := camera.global_position

	var w := size.x
	var half := w * 0.5
	var fov_half := PI * 0.5 # ±90 degrees

	for marker in markers:
		var marker_2d := markers[marker]
		var dir := marker.global_position - pos
		var marker_angle := atan2(dir.x, -dir.z)
		var diff := wrapf(marker_angle - yaw, -PI, PI)
		#if abs(diff) > fov_half:
			#marker_2d.visible = false
			#continue
		#marker_2d.visible = true
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
