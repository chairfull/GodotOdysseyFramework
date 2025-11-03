extends HumanoidState

var camera: CameraTarget
var _crouch_hold_time := 0.0
var _crouch_held := false
var _interactive: Interactive
var _interactive_hud: Node

func _enter_tree() -> void:
	super()
	if is_player():
		camera = humanoid.get_node_or_null("camera")
		if not camera:
			camera = Assets.create_prefab(&"camera_follow", humanoid)
			camera.name = "camera"
		camera.target = humanoid
		camera.set_third_person()
		humanoid.get_node(^"%model").visible = true
		_interactive_hud = _controller_player.show_hud(&"interaction_label")
	else:
		set_process(false)
		set_process_unhandled_input(false)

func _exit_tree() -> void:
	#super()
	if is_player():
		_controller_player.hide_hud(&"interaction_label")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		if humanoid.interact_start():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"fire"):
		if humanoid.fire():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"reload"):
		if humanoid.reload():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"jump"):
		if humanoid.prone_state in [Humanoid.ProneState.Crouch, Humanoid.ProneState.Crawl]:
			humanoid.stand()
		else:
			humanoid.jump_start()
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"jump"):
		if humanoid.jump_end():
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
		elif humanoid.is_crawling():
			humanoid.crouch()
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		if humanoid.is_crouching():
			humanoid.stand()
		get_viewport().set_input_as_handled()
		
func _process(delta: float) -> void:
	camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	humanoid.get_node("%head").global_rotation = camera.camera.global_rotation
	
	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not humanoid.is_crawling():
				humanoid.crawl()

func _physics_process(delta: float) -> void:
	var inter: Interactive = humanoid.interactive_detector.get_nearest()
	if inter != _interactive:
		if _interactive:
			_interactive.highlight = Interactive.Highlight.NONE
		_interactive = inter
		_interactive_hud.interactive = inter
		if _interactive:
			_interactive.highlight = Interactive.Highlight.FOCUSED
	
	var input_dir := _controller_player.get_move_vector_camera()
	
	if humanoid.is_focusing():
		var cam_dir := camera.camera.global_rotation.y
		humanoid.direction = lerp_angle(humanoid.direction, cam_dir, delta * 10.0)
	else:
		if input_dir:
			humanoid.direction = lerp_angle(humanoid.direction, -input_dir.angle() - PI * .5, delta * 10.0)
	
	humanoid.movement = input_dir
	
	var cam := camera.camera
	var mp := cam.get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(mp)
	var to := from + cam.project_ray_normal(mp) * 1000.0
	
	var space := cam.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [humanoid]
	var hit := space.intersect_ray(query)
	var target_pos = hit.position if hit else to
	
	if inter:
		humanoid.looking_at = inter.global_position + inter.humanoid_lookat_offset
	else:
		humanoid.looking_at = target_pos
