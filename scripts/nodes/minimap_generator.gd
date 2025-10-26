@tool
class_name MinimapGenerator extends SubViewport
## WARNING: Cells are stores as (z, x, y)

const CAMERA_HEIGHT := 10.0
const SAVE_DIR := "res://assets/_debug"

@export var packed_scene: PackedScene
@export_enum("webp", "png", "jpg") var texture_format := "webp"
@export var cell_meters := 16.0 ## Are of game space to render per cell.
@export var cell_pixels := 512 ## Texture size.

@export_tool_button("Run") var run := func():
	size = Vector2i(cell_pixels, cell_pixels)
	
	var scene := packed_scene.instantiate()
	scene.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(scene)
	print("Generating minimap for %s." % scene.scene_file_path)
	
	var camera: Camera3D = %camera
	camera.size = cell_meters
	camera.make_current()
	
	# Collect occupied cells.
	var cells: Array[Vector3i]
	var navs := scene.find_children("", "NavigationRegion3D", true, true)
	for nav: NavigationRegion3D in navs:
		var verts := nav.navigation_mesh.get_vertices()
		for i in nav.navigation_mesh.get_polygon_count():
			var poly := nav.navigation_mesh.get_polygon(i)
			# convert polygon to Vector2 list (X,Z)
			var poly2d := []
			var min_x := 1e9
			var max_x := -1e9
			var min_z := 1e9
			var max_z := -1e9
			for idx in poly:
				var v: Vector3 = verts[idx]
				poly2d.append(Vector2(v.x, v.z))
				min_x = min(min_x, v.x)
				max_x = max(max_x, v.x)
				min_z = min(min_z, v.z)
				max_z = max(max_z, v.z)
			var start_x := int(floor(min_x / cell_meters))
			var end_x   := int(floor(max_x / cell_meters))
			var start_z := int(floor(min_z / cell_meters))
			var end_z   := int(floor(max_z / cell_meters))
			for cx in range(start_x, end_x + 1):
				for cz in range(start_z, end_z + 1):
					var center := Vector2(cx, cz) * (cell_meters + cell_meters * 0.5)
					var cell := Vector3i(0, cx, cz)
					if not cell in cells and Geometry2D.is_point_in_polygon(center, poly2d):
						cells.append(cell)
	
	if not cells:
		push_error("No cells. Is there a NavigationRegion3d?")
		return
	
	cells.sort()
	
	var scene_name := scene.scene_file_path.get_basename().get_file()
	var save_dir := SAVE_DIR.path_join(scene_name)
	var err := DirAccess.make_dir_recursive_absolute(save_dir)
	if err != OK:
		push_error("Couldn't create dir: %s" % save_dir)
		return
	
	var save_path: String
	
	for cell in cells:
		camera.global_position = Vector3(
			(cell.y * cell_meters) + cell_meters * .5,
			CAMERA_HEIGHT,
			(cell.z * cell_meters) + cell_meters * .5)
		await get_tree().process_frame
		var img := get_texture().get_image()
		save_path = save_dir.path_join("%s_%s_%s.%s" % [cell.x, cell.y, cell.z, texture_format])
		match texture_format:
			"webp": err = img.save_webp(save_path)
			"png": err = img.save_png(save_path)
			"jpg": err = img.save_jpg(save_path)
		if err != OK:
			push_error("Couldn't save %s." % save_path)
		else:
			print("Saved cell: %s." % save_path)
	
	var res := MinimapData.new()
	res.scene = scene.scene_file_path
	res.cells = cells
	res.meters = camera.size
	res.texture_size = size
	res.texture_format = texture_format
	save_path = save_dir.path_join("minimap.tres")
	ResourceSaver.save(res, save_path)
	print("Saved data: %s." % save_path)
	
	remove_child(scene)
	scene.queue_free()
