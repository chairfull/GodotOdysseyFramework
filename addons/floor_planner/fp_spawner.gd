@tool
class_name FPSpawner extends Node2D

@export var prefab: PackedScene: set=set_prefab
@export var preview_color := Color.REBECCA_PURPLE: set=set_preview_color
@export_storage var preview_rect: Rect2
var root: FPRoot:
	get: return owner

@export_tool_button("Regenerate Preview") var _tb_regen_prev := update_preview
@export var preview_texture: ImageTexture

func update_preview() -> void:
	#var instance: Node3D = prefab.instantiate()
	#var aabb: AABB = get_aabb(instance)
	#preview_rect.position = Vector2(aabb.position.x, aabb.position.z)
	#preview_rect.size = Vector2(aabb.size.x, aabb.size.z)
	#instance.queue_free()
	
	_update_snapshot_from_prefab()
	
	queue_redraw()

func _update_snapshot_from_prefab():
	if not prefab:
		return
	
	var preview_size := 128
	var temp_root := Node3D.new()
	var instance: Node3D = prefab.instantiate()
	temp_root.add_child(instance)
	
	# Get AABB first for camera setup
	var aabb := get_aabb(instance)
	var bounds_size := maxf(aabb.size.x, aabb.size.z)  # For ortho size; adjust if asymmetric
	var center := aabb.position + aabb.size / 2.0
	
	# Create a sub-viewport for rendering the 3D snapshot
	var viewport := SubViewport.new()
	viewport.size = Vector2(preview_size, preview_size)
	viewport.transparent_bg = true
	viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	viewport.own_world_3d = true
	
	var light := DirectionalLight3D.new()
	light.rotation_degrees.x = -90
	viewport.add_child(light)
	
	viewport.add_child(temp_root)
	
	var camera := Camera3D.new()
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = bounds_size * .5
	camera.position = center + Vector3.UP * aabb.size.y
	camera.rotation_degrees = Vector3(-90, 0, 0)
	camera.make_current()
	temp_root.add_child(camera)
	
	add_child(viewport)
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Capture the texture
	preview_texture = ImageTexture.create_from_image(viewport.get_texture().get_image())
	
	# Cleanup
	viewport.queue_free()
	temp_root.queue_free()
	
	queue_redraw()

func set_prefab(p: PackedScene) -> void:
	prefab = p
	update_preview()
	queue_redraw()
	
func set_preview_color(c: Color) -> void:
	preview_color = c
	queue_redraw()

func _draw() -> void:
	var size := preview_rect.size * root.pixels_per_meter
	var pos := preview_rect.position * root.pixels_per_meter
	draw_rect(Rect2(pos, size), preview_color, true, -1, true)
	
	draw_texture(preview_texture, Vector2.ZERO - preview_texture.get_size() * .5, Color.WHITE)
	
	if prefab:
		var font := ThemeDB.fallback_font
		var fsize := ThemeDB.fallback_font_size
		var text := prefab.resource_path.get_basename().get_file()
		var center := -font.get_string_size(text, HORIZONTAL_ALIGNMENT_CENTER, -1, fsize) * .5
		center.y += font.get_ascent(fsize)
		draw_string(font, center, text, HORIZONTAL_ALIGNMENT_CENTER, -1, fsize, Color.BLACK)

static func get_aabb(node: Node) -> AABB:
	return _get_aabb_worker(node, AABB())

static func _get_aabb_worker(node: Node, aabb: AABB) -> AABB:
	if node.has_method(&"get_aabb"):
		var ret: Variant = node.call(&"get_aabb")
		if ret is AABB:
			aabb = aabb.merge(ret)
	for child in node.get_children():
		aabb = _get_aabb_worker(child, aabb)
	return aabb
