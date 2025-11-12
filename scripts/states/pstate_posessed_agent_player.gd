class_name PStatePosessedAgentPlayer extends PStatePosessed

var agent: Agent:
	get: return pawn.node

var camera: CameraTarget ## TODO: Move to controller...
var _crouch_hold_time := 0.0
var _crouch_held := false
var _interactive_hud: Widget

func _accept_controller(con: Controller) -> bool:
	return con is ControllerPlayer

func _enable() -> void:
	super()

	#agent.interactive_detector.visible_changed.connect(agent.interactive_changed.emit)
	get_player_controller().view_state_changed.connect(_view_state_changed)
	if not camera:
		camera = Assets.create_scene(&"camera_follow", true)
		camera.target = agent
		get_player_controller().camera_master.target = camera.camera
		camera.get_node("%head_remote").remote_path = agent.get_node("%head").get_path()
		
		var remote := RemoteTransform3D.new()
		remote.name = "camera_target"
		remote.update_position = true
		remote.update_rotation = false
		remote.update_scale = false
		agent.get_node("%head").add_child(remote)
		remote.remote_path = camera.get_path()
		
		_view_state_changed()
	get_player_controller().show_widgit(&"toast_manager")
	_interactive_hud = get_player_controller().show_widgit(&"interaction_label")
	_interactive_hud.set_agent(agent)

func _disable() -> void:
	super()
	
	_interactive_hud = null
	#agent.interactive_detector.visible_changed.disconnect(agent.interactive_changed.emit)
	get_player_controller().view_state_changed.disconnect(_view_state_changed)
	get_player_controller().hide_widgit(&"interaction_label")
	get_player_controller().hide_widgit(&"toast_manager")

func _view_state_changed():
	match get_player_controller().view_state:
		ControllerPlayer.ViewState.FirstPerson:
			Global.wait(0.35, get_player_controller().show_fps_viewport)
			await camera.set_first_person()
			agent.get_node(^"%model").visible = false
		ControllerPlayer.ViewState.ThirdPerson:
			get_player_controller().hide_fps_viewport()
			camera.set_third_person()
			agent.get_node(^"%model").visible = true

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	get_player_controller()._event = event
	
	if is_action_pressed(&"quick_equip_menu"):
		get_player_controller().show_widgit(&"menu", { choices=[
			{ text="Yes"},
			{ text="No" },
			{ text="Maybe"}
		]})
		handle_input()
		
	elif is_action_pressed(&"toggle_quest_log"):
		get_player_controller().toggle_widgit(&"quest_log")
	
	elif is_action_pressed(&"interact"):
		if agent.interact_start(pawn):
			handle_input()
	elif is_action_released(&"interact"):
		if agent.interact_stop(pawn):
			handle_input()
	
	elif is_action_both(&"fire", agent.fire_start, agent.fire_stop): pass
	elif is_action_both(&"reload", agent.reload_start, agent.reload_stop): pass
	
	elif is_action_pressed(&"jump"):
		print("jump")
		if agent.prone_state in [Humanoid.ProneState.Crouch, Humanoid.ProneState.Crawl]:
			agent.stand()
		else:
			agent.jump_start()
		handle_input()
	elif is_action_released(&"jump"):
		print("release jump")
		if agent.jump_stop():
			handle_input()
	
	elif is_action_pressed(&"drop"):
		if agent.drop():
			handle_input()
	
	elif is_action_both(&"aim", agent.focus_start, agent.focus_stop): pass
	#elif is_action_pressed(&"aim"):
		#agent.focus_start()
		#camera.focus()
		#handle_input()
	#elif is_action_released(&"aim"):
		#agent.focus_stop()
		#camera.unfocus()
		#handle_input()
		
	elif is_action_pressed(&"crouch", false, true):
		_crouch_held = true
		if agent.is_standing():
			agent.crouch()
		elif agent.is_crawling():
			agent.crouch()
		handle_input()
	elif is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		if agent.is_crouching():
			agent.stand()
		handle_input()
	
	elif is_action_both(&"sprint", agent.sprint_start, agent.sprint_stop): pass

func _process(delta: float) -> void:
	#camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	#humanoid.get_node("%head").global_rotation = camera.camera.global_rotation
	
	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not agent.is_crawling():
				agent.crawl()

func _physics_process(delta: float) -> void:
	var inter: Interactive
	if is_third_person():
		var pos := agent.interactive_detector.global_position
		inter = agent.interactive_detector.get_nearest(pos)
	elif is_first_person():
		inter = agent.interactive_detector.get_nearest(agent.looking_at)
	
	if inter != agent._interactive:
		if agent._interactive:
			agent._interactive.highlight = Interactive.Highlight.NONE
		agent._interactive = inter
		if agent._interactive:
			agent._interactive.highlight = Interactive.Highlight.FOCUSED
	
	var input_dir := get_player_controller().get_move_vector_camera()
	
	if agent.is_focusing():
		var cam_dir := camera.camera.global_rotation.y
		agent.direction = lerp_angle(agent.direction, cam_dir, delta * 10.0)
	else:
		if input_dir:
			agent.direction = lerp_angle(agent.direction, -input_dir.angle() - PI * .5, delta * 10.0)
	
	agent.movement = input_dir
	
	var cam := camera.camera
	var mp := cam.get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(mp)
	var to := from + cam.project_ray_normal(mp) * 1000.0
	var space := cam.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [agent]
	var hit := space.intersect_ray(query)
	var target_pos = hit.position if hit else to
	
	agent.looking_at = target_pos
	
	if inter:
		agent.head_looking_at = inter.global_position + inter.humanoid_lookat_offset
		agent.head_looking_amount = 1.0
	elif agent.is_focusing():
		agent.head_looking_at = target_pos
		agent.head_looking_amount = 1.0
	else:
		var node: Node3D = agent.get_node("%direction")
		var forward := -node.global_transform.basis.z
		var front_pos := node.global_position + forward * 2.0 + Vector3.UP * 1.3
		agent.head_looking_at = front_pos
		agent.head_looking_amount = 0.0
