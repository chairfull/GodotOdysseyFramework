@tool
class_name FPRoot3D extends Node3D

var root: FPRoot:
	get: return owner

@export var debug_colors := true
@export_tool_button("Regenerate") var tb_regenerate := regenerate

func regenerate() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	var csg := CSGCombiner3D.new()
	add_child(csg)
	csg.owner = root
	csg.name = owner.name + "_3d"
	
	var trans := Transform2D.IDENTITY.scaled(Vector2.ONE * (1.0 / root.pixels_per_meter))
	
	_generate(root, csg, trans)
	
func _generate(source: Node, target: Node, trans: Transform2D) -> void:
	for source_child in source.get_children():
		if source_child is FPPolygon:
			var target_child: CSGPolygon3D = _create(CSGPolygon3D.new(), target, source_child, trans)
			target_child.depth = source_child.depth
			target_child.operation = source_child.operation
			target_child.material = source_child.material_3d
			target_child.polygon = source_child.polygon * trans
			target_child.global_rotation_degrees.x = 90
			if debug_colors:
				var mat := StandardMaterial3D.new()
				mat.albedo_color = source_child.color
				target_child.material = mat
			_generate(source_child, target_child, trans)
		elif source_child is FPSpawner:
			var target_child := _create(source_child.prefab.instantiate(), target, source_child, trans)
			_generate(source_child, target_child, trans)

func _create(target_child: Node, target: Node, source_child: Node, trans: Transform2D) -> Node3D:
	target.add_child(target_child)
	target_child.owner = root
	target_child.name = source_child.name
	target_child.global_position = xz(source_child.global_position * trans)
	target_child.global_rotation.y = source_child.global_rotation
	return target_child
	
func xz(pos: Vector2) -> Vector3:
	return Vector3(pos.x, 0, pos.y)
