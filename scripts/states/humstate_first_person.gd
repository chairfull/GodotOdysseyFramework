extends HumanoidState

var camera: CameraTarget

func _enter_tree() -> void:
	await humanoid.get_tree().process_frame
	humanoid.get_node("%mesh").visible = false
	camera = Prefabs.create(&"camera_first_person", humanoid)
	camera.get_node("%gimbal").position.y = humanoid.get_node("%head").position.y
	prints("Create camera", camera, humanoid, camera.get_parent())

func _exit_tree() -> void:
	humanoid.get_node("%mesh").visible = true
	humanoid.remove_child(camera)
	camera.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		if humanoid.interact():
			get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed(&"fire"):
		var cam := camera.camera
		var mp := cam.get_viewport().get_mouse_position()
		var from := cam.project_ray_origin(mp)
		var to := from + cam.project_ray_normal(mp) * 1000.0
		
		var space := cam.get_world_3d().direct_space_state
		var hit := space.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
		var target_pos = hit.position if hit else to
		
		camera.get_node("%cursor").global_position = target_pos
		humanoid.looking_at = target_pos
		if humanoid.fire():
			get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed(&"reload"):
		if humanoid.reload():
			get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	humanoid.get_node("%head").global_rotation = camera.camera.global_rotation

func _physics_process(_delta: float) -> void:
	if not camera: return
	var dir := camera.camera.global_rotation.y
	humanoid.direction = dir + PI * .5
	
	var input_dir := ControllerPlayer.get_move_vector()
	input_dir = input_dir.rotated(-dir)
	
	var move_speed := 5.0
	var sprint_speed := 9.0
	var speed := move_speed
	if Input.is_action_pressed(&"sprint"):
		speed = sprint_speed
	humanoid.movement = input_dir * speed
	
	if Input.is_action_just_pressed(&"jump"):
		humanoid.jump = true
