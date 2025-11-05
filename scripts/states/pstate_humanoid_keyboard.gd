extends PawnState

var camera: CameraTarget
var humanoid: Humanoid:
	get: return pawn
var _crouch_hold_time := 0.0
var _crouch_held := false
var _interactive: Interactive
var _interactive_hud: Node

func _enable() -> void:
	process_priority = 200
	process_physics_priority = 200
	
	super()
	get_player_controller().view_state_changed.connect(_view_state_changed)
	if not camera:
		camera = Assets.create_prefab(&"camera_follow", get_tree().current_scene)
		camera.target = humanoid
		get_player_controller().camera_master.target = camera.camera
		camera.get_node("%head_remote").remote_path = humanoid.get_node("%head").get_path()
		
		var remote := RemoteTransform3D.new()
		remote.name = "camera_target"
		remote.update_position = true
		remote.update_rotation = false
		remote.update_scale = false
		humanoid.get_node("%head").add_child(remote)
		remote.remote_path = camera.get_path()
		
		_view_state_changed()
	_interactive_hud = get_player_controller().show_hud(&"interaction_label")

func _disable() -> void:
	super()
	_interactive_hud = null
	get_player_controller().view_state_changed.disconnect(_view_state_changed)
	get_player_controller().hide_hud(&"interaction_label")

func _view_state_changed():
	match pawn.player_controller.view_state:
		ControllerPlayer.ViewState.FirstPerson:
			Global.wait(0.35, get_player_controller().show_fps_viewport)
			await camera.set_first_person()
			humanoid.get_node(^"%model").visible = false
		ControllerPlayer.ViewState.ThirdPerson:
			get_player_controller().hide_fps_viewport()
			camera.set_third_person()
			humanoid.get_node(^"%model").visible = true

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	
	if event.is_action_pressed(&"toggle_quest_log"):
		get_player_controller().toggle_hud(&"quest_log")
	
	if event.is_action_pressed(&"interact"):
		if humanoid.interact_start(_interactive):
			get_viewport().set_input_as_handled()
	elif event.is_action_released(&"interact"):
		if humanoid.interact_stop():
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
	
	elif event.is_action_pressed(&"sprint"):
		if humanoid.sprint_start():
			get_viewport().set_input_as_handled()
	elif event.is_action_released(&"sprint"):
		if humanoid.sprint_end():
			get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	#camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	#humanoid.get_node("%head").global_rotation = camera.camera.global_rotation
	
	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not humanoid.is_crawling():
				humanoid.crawl()

func _physics_process(delta: float) -> void:
	var inter: Interactive
	if is_third_person():
		var pos := humanoid.interactive_detector.global_position
		inter = humanoid.interactive_detector.get_nearest(pos)
	elif is_first_person():
		inter = humanoid.interactive_detector.get_nearest(humanoid.looking_at)
	
	if inter != _interactive:
		if _interactive:
			_interactive.highlight = Interactive.Highlight.NONE
		_interactive = inter
		_interactive_hud.interactive = inter
		if _interactive:
			_interactive.highlight = Interactive.Highlight.FOCUSED
	
	var input_dir := get_player_controller().get_move_vector_camera()
	
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
	
	humanoid.looking_at = target_pos
	
	if inter:
		humanoid.head_looking_at = inter.global_position + inter.humanoid_lookat_offset
		humanoid.head_looking_amount = 1.0
	elif humanoid.is_focusing():
		humanoid.head_looking_at = target_pos
		humanoid.head_looking_amount = 1.0
	else:
		var node: Node3D = humanoid.get_node("%direction")
		var forward_dir := -node.global_transform.basis.z
		var front_pos := node.global_position + forward_dir * 2.0 + Vector3.UP * 1.3
		humanoid.head_looking_at = front_pos
		humanoid.head_looking_amount = 0.0
