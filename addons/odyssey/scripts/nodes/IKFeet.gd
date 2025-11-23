@tool
class_name SkeletonFootLimit extends SkeletonModifier3D

@export var ray: RayCast3D
@export var bone_name: String
@export var remote: Node3D
@export var hit_position := Vector3.ZERO

func _process_modification_with_delta(_delta: float) -> void:
	var skeleton := get_skeleton()
	if not skeleton: return
	
	var bone := skeleton.find_bone(bone_name)
	if bone == -1: return
	var pose := skeleton.get_bone_global_pose(bone)
	var world_pose := skeleton.global_transform * pose
	ray.global_position = world_pose.origin
	ray.position.y = -ray.target_position.y * .5
	var ray_dest := ray.global_position + ray.target_position
	var data := get_hit_data()
	if data:
		var hit_pos: Vector3 = data[0]
		world_pose.origin = hit_pos
	hit_position = (ray_dest - world_pose.origin)
	if remote:
		remote.global_position = world_pose.origin

func get_hit_data() -> Array:
	if Engine.is_editor_hint():
		var cam := EditorInterface.get_editor_viewport_3d(0).get_camera_3d()
		if cam:
			var world := cam.get_world_3d().direct_space_state
			var query := PhysicsRayQueryParameters3D.create(ray.global_position, ray.global_position + ray.target_position, ray.collision_mask)
			var hit := world.intersect_ray(query)
			if hit:
				return [hit.position, hit.normal]
	elif ray.is_colliding():
		return [ray.get_collision_point(), ray.get_collision_normal()]
	return []
