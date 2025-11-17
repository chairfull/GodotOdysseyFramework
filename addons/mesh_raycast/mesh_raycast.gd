@tool
class_name MeshRayCast extends RayCast3D

@export var mat: ShaderMaterial
@export var clr: Color

func _process(delta: float) -> void:
	var max_distance := 10.0
	mat.set_shader_parameter(&"target_position", global_position)
	mat.set_shader_parameter(&"max_distance", max_distance)
	var tex: ViewportTexture = %viewport.get_texture()
	var img: Image = tex.get_image()
	img.convert(Image.FORMAT_RGB16)
	#img.linear_to_srgb()
	clr = img.get_pixel(1, 1)

	
	# Decode normal from spherical
	var phi: float = clr.g * 2.0 * PI - PI
	var theta: float = clr.b * PI
	var extracted_normal: Vector3 = Vector3(
		sin(theta) * cos(phi),
		cos(theta),
		sin(theta) * sin(phi)
	)
	
	var dist := clr.r * max_distance + .15
	%cursor.global_position = global_position - global_basis.z * dist
	%c2.position = extracted_normal*.5
	
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

#func _update_snapshot_from_prefab():
	#if not prefab:
		#return
	#
	#var preview_size := 128
	#var temp_root := Node3D.new()
	#var instance: Node3D = prefab.instantiate()
	#temp_root.add_child(instance)
	#
	## Get AABB first for camera setup
	#var aabb := get_aabb(instance)
	#var bounds_size := maxf(aabb.size.x, aabb.size.z)  # For ortho size; adjust if asymmetric
	#var center := aabb.position + aabb.size / 2.0
	#
	## Create a sub-viewport for rendering the 3D snapshot
	#var viewport := SubViewport.new()
	#viewport.size = Vector2(preview_size, preview_size)
	#viewport.transparent_bg = true
	#viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	#viewport.own_world_3d = true
	#
	#var light := DirectionalLight3D.new()
	#light.rotation_degrees.x = -90
	#viewport.add_child(light)
	#
	#viewport.add_child(temp_root)
	#
	#var camera := Camera3D.new()
	#camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	#camera.size = bounds_size * .5
	#camera.position = center + Vector3.UP * aabb.size.y
	#camera.rotation_degrees = Vector3(-90, 0, 0)
	#camera.make_current()
	#temp_root.add_child(camera)
	#
	#add_child(viewport)
	#viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	#await get_tree().process_frame
	#await get_tree().process_frame
	#
	## Capture the texture
	#preview_texture = ImageTexture.create_from_image(viewport.get_texture().get_image())
	#
	## Cleanup
	#viewport.queue_free()
	#temp_root.queue_free()
	#
	#queue_redraw()
