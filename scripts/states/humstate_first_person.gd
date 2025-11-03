extends HumanoidState

var camera: CameraTarget
var _crouch_hold_time := 0.0
var _crouch_held := false

func _enter_tree() -> void:
	super()
	
	if is_player():
		humanoid.prone_state_changed.connect(func(): camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y)
		camera = humanoid.get_node_or_null("camera")
		if not camera:
			camera = Assets.create_prefab(&"camera_follow", humanoid)
			camera.name = "camera"
		camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
		camera.target = humanoid
		await camera.set_first_person()
		humanoid.get_node(^"%model").visible = false
	else:
		set_process(false)
		set_process_unhandled_input(false)

func _startstop(ev: InputEvent, key: StringName, meth_start: StringName, meth_stop: StringName) -> bool:
	if ev.is_action_pressed(key):
		if humanoid.call(meth_start):
			get_viewport().set_input_as_handled()
			return true
	elif ev.is_action_released(key):
		if humanoid.call(meth_stop):
			get_viewport().set_input_as_handled()
			return true
	return false

func _unhandled_input(event: InputEvent) -> void:
	if _startstop(event, &"interact", &"interact_start", &"interact_stop"):
		pass
	elif event.is_action_pressed(&"fire"):
		if humanoid.fire():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"reload"):
		if humanoid.reload():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"jump", false, true):
		if humanoid.is_crawling() or humanoid.is_crouching():
			humanoid.stand()
		elif humanoid.is_standing():
			humanoid.jump = true
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"drop"):
		if humanoid.drop():
			get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed(&"aim"):
		humanoid.focus()
		camera.focus()
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"aim"):
		humanoid.unfocus()
		camera.unfocus()
		get_viewport().set_input_as_handled()
		
	elif event.is_action_pressed(&"crouch", false, true):
		_crouch_held = true
		if humanoid.is_standing():
			humanoid.crouch()
		elif humanoid.is_crouching():
			humanoid.stand()
		elif humanoid.is_crawling():
			humanoid.crouch()
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		get_viewport().set_input_as_handled()
	
	elif _startstop(event, &"sprint", &"sprint_start", &"sprint_end"):
		return
		
func _process(delta: float) -> void:
	camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	humanoid.get_node("%head").global_rotation = camera.camera.global_rotation

	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not humanoid.is_crawling():
				humanoid.crawl()

func _physics_process(_delta: float) -> void:
	if not camera: return
	var dir := camera.camera.global_rotation.y
	humanoid.direction = dir + PI * .5
	
	var input_dir := _controller_player.get_move_vector()
	humanoid.movement = input_dir
	
	var cam := camera.camera
	var mp := cam.get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(mp)
	var to := from + cam.project_ray_normal(mp) * 1000.0
	
	var space := cam.get_world_3d().direct_space_state
	var hit := space.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
	var target_pos = hit.position if hit else to
	
	humanoid.looking_at = target_pos
