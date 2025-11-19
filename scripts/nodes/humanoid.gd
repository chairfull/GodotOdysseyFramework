class_name Humanoid extends CharNode

#var camera: CameraTarget ## TODO: Move to controller...
var _crouch_hold_time := 0.0
var _crouch_held := false

func stand():
	_next_prone_state = ProneState.Stand
	UTween.parallel(self, {
		#"%head:position:y": 1.5,
		"%collision_shape:position:y": 1.0,
		"%collision_shape:shape:height": 2.0}, 0.2, &"prone").finished.connect(func():
		prone_state = ProneState.Stand
		prone_state_changed.emit())

func crouch():
	_next_prone_state = ProneState.Crouch
	UTween.parallel(self, {
		#"%head:position:y": 0.5,
		"%collision_shape:position:y": 0.5,
		"%collision_shape:shape:height": 1.0 }, 0.2, &"prone").finished.connect(func():
		prone_state = ProneState.Crouch
		prone_state_changed.emit())
	
func crawl():
	_next_prone_state = ProneState.Crawl
	UTween.parallel(self, {
		#"%head:position:y": 0.2,
		"%collision_shape:position:y": 0.25,
		"%collision_shape:shape:height": 0.5}, 0.2, &"prone").finished.connect(func():
		prone_state = ProneState.Crawl
		prone_state_changed.emit())

func _controlled() -> void:
	super()
	
	_controller.view_state_changed.connect(_view_state_changed)
	_controller.show_widget(&"compass_markers")
	_controller.show_widget(&"screen_space_markers")
	_controller.show_widget(&"toast_manager")
	_controller.show_widget(&"world_time")
	_controller.show_widget(&"interaction_label")
	_view_state_changed()
	
	# Copy camera rotation to head.
	_controller.pawn_camera.get_node("%remote").remote_path = %head.get_path()
	
	# Copy head position to camera.
	var remote := RemoteTransform3D.new()
	%head.add_child(remote)
	remote.name = "camera_remote"
	remote.update_position = true
	remote.update_rotation = false
	remote.update_scale = false
	remote.remote_path = _controller.pawn_camera.get_path()

func _uncontrolled() -> void:
	super()
	_controller.view_state_changed.disconnect(_view_state_changed)
	_controller.hide_widget(&"compass_markers")
	_controller.hide_widget(&"screen_space_markers")
	_controller.hide_widget(&"interaction_label")
	_controller.hide_widget(&"world_time")
	_controller.hide_widget(&"toast_manager")
	
	_controller.pawn_camera.get_node("%remote").remote_path = ""
	
	var remote := %head.get_node_or_null("camera_remote")
	if remote:
		%head.remove_child(remote)
		remote.queue_free()

func _view_state_changed():
	match _controller.view_state:
		PlayerController.ViewState.FirstPerson:
			Global.wait(0.35, _controller.show_fps_viewport)
			await _controller.pawn_camera.set_first_person()
			%model.visible = false
		PlayerController.ViewState.ThirdPerson:
			_controller.hide_fps_viewport()
			_controller.pawn_camera.set_third_person()
			%model.visible = true

func tell_npc(method: StringName, ...args) -> void:
	for npc in Global.get_tree().get_nodes_in_group(&"npc"):
		if npc != _controller.pawn:
			npc.callv(method, args)

func _update_as_controlled(delta: float) -> void:
	if is_action_pressed(&"quick_equip_menu"):
		_controller.show_widget(&"menu", { choices=[
			{ text="Follow", call=tell_npc.bind(&"move_to", global_position) },
			{ text="Set: Hostile" },
			{ text="Set: Neutral" },
			{ text="Set: Scared" },
			{ text="Use: Vehcile" },
			{ text="Use: Chair" },
			{ text="Use: Item" },
		]})
		handle_input()
		
	elif is_action_pressed(&"toggle_quest_log"):
		_controller.toggle_widget(Assets.WIDGET_QUEST_LOG)
	
	elif is_action_both(&"interact", interact_start, interact_stop): pass
	elif is_action_both(&"interact_alt", interact_alt_start, interact_alt_stop): pass
	
	elif is_action_both(&"fire", fire_start, fire_stop): pass
	elif is_action_both(&"reload", reload_start, reload_stop): pass
	
	elif is_action_pressed(&"jump"):
		if prone_state in [Humanoid.ProneState.Crouch, Humanoid.ProneState.Crawl]:
			stand()
		else:
			jump_start()
		handle_input()
	elif is_action_released(&"jump"):
		if jump_stop():
			handle_input()
	
	elif is_action_pressed(&"drop"):
		if unequip():
			handle_input()
	
	elif is_action_both(&"aim", focus_start, focus_stop): pass
	#elif is_action_pressed(&"aim"):
		#agent.focus_start()
		#camera.focus()
		#handle_input()
	#elif is_action_released(&"aim"):
		#agent.focus_stop()
		#camera.unfocus()
		#handle_input()
		
	elif is_action_pressed(&"crouch", true):
		_crouch_held = true
		if is_standing():
			crouch()
		elif is_crawling():
			crouch()
		handle_input()
	elif is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		if is_crouching():
			stand()
		handle_input()
	
	elif is_action_both(&"sprint", sprint_start, sprint_stop): pass
	
	#camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	#humanoid.get_node("%head").global_rotation = camera.camera.global_rotation
	
	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not is_crawling():
				crawl()
	
	var inter: Interactive
	if _controller.is_third_person():
		var pos := interactive_detector.global_position
		inter = interactive_detector.get_nearest(pos)
	elif _controller.is_first_person():
		inter = interactive_detector.get_nearest(looking_at)
	
	if inter != _interactive:
		if _interactive:
			_interactive.highlight = Interactive.Highlight.NONE
		_interactive = inter
		if _interactive:
			_interactive.highlight = Interactive.Highlight.FOCUSED
	
	var input_dir := _controller.get_move_vector_camera()
	var cam: Camera3D = _controller.pawn_camera.camera
	
	if is_focusing():
		var cam_dir := cam.global_rotation.y
		direction = lerp_angle(direction, cam_dir, delta * 10.0)
	else:
		if input_dir:
			direction = lerp_angle(direction, -input_dir.angle() - PI * .5, delta * 10.0)
	
	movement = input_dir
	
	var mp := cam.get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(mp)
	var to := from + cam.project_ray_normal(mp) * 1000.0
	var space := cam.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [body.get_rid()]
	var hit := space.intersect_ray(query)
	var target_pos = hit.position if hit else to
	
	looking_at = target_pos
	
	if inter:
		head_looking_at = inter.global_position + inter.humanoid_lookat_offset
		head_looking_amount = 1.0
	elif is_focusing():
		head_looking_at = target_pos
		head_looking_amount = 1.0
	else:
		var node: Node3D = %direction
		var forward := -node.global_transform.basis.z
		var front_pos := node.global_position + forward * 2.0 + Vector3.UP * 1.3
		head_looking_at = front_pos
		head_looking_amount = 0.0
