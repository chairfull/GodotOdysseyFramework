extends HumanoidState

var camera: CameraTarget
var cursor: Node3D
var path: PackedVector3Array

func _enter_tree() -> void:
	camera = Assets.create_prefab(&"camera_top_down", humanoid)
	cursor = Assets.create_prefab(&"cursor", humanoid)

func _exit_tree() -> void:
	humanoid.remove_child(camera)
	camera.queue_free()
	humanoid.remove_child(cursor)
	cursor.queue_free()

#func _physics_process(_delta: float) -> void:
	##humanoid.direction = -camera.camera.global_rotation.y
	#
	#var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	#input_dir = input_dir.rotated(-camera.camera.global_rotation.y)
	#
	#var move_speed := 5.0
	#var sprint_speed := 9.0
	#var speed := move_speed
	#if Input.is_action_pressed(&"sprint"):
		#speed = sprint_speed
	#humanoid.movement = input_dir * speed
	#
	#if Input.is_action_just_pressed(&"jump"):
		#humanoid.jump = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"click", true):
		print("Goto ", cursor.global_position)
		humanoid.move_to(cursor.global_position)
		get_viewport().set_input_as_handled()

func _physics_process(_delta: float) -> void:
	var vp := get_viewport()
	var cam := vp.get_camera_3d()
	var mp := vp.get_mouse_position()
	var origin := cam.project_ray_origin(mp)
	var normal := cam.project_ray_normal(mp)
	var query := PhysicsRayQueryParameters3D.create(origin, origin + normal * 1000.0)
	query.collide_with_bodies = true
	var space_state := cam.get_world_3d().direct_space_state
	var result := space_state.intersect_ray(query)
	if result:
		var hit_pos: Vector3 = result.position
		cursor.global_position = hit_pos
