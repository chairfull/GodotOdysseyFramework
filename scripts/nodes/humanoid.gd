class_name Humanoid extends CharNode

#var camera: CameraTarget ## TODO: Move to controller...
var _crouch_hold_time := 0.0
var _crouch_held := false
var _interactive_hud: Widget

#func equip(item_node: ItemNode, equip_id: StringName):
	#var parent := get_node("%equip_" + equip_id)
	#item_node.reparent(parent)
	#
	#if is_equipped(equip_id):
		#unequip(equip_id)
	#
	#_equipped[equip_id] = item_node
	#
	#print("TODO: PICKUP")
	#var dummy := MeshInstance3D.new()
	#get_tree().current_scene.add_child(dummy)
	#dummy.mesh = BoxMesh.new()
	#dummy.mesh.size = Vector3.ONE * .2
	#dummy.layers = 1<<1
	#var camera := player_controller.camera_master.target.get_parent()
	#var remote := RemoteTransform3D.new()
	#camera.add_child(remote)
	#remote.remote_path = dummy.get_path()
	#remote.position = Vector3(-0.2, -0.2, -0.2)
	
	#_held_item = item_node
	#_held_item.item._node_equipped(_held_item)
	#_held_item.mount = self
	#_held_item.process_mode = Node.PROCESS_MODE_DISABLED
	#
	#_held_item_remote = RemoteTransform3D.new()
	#camera.add_child(_held_item_remote)
	#_held_item_remote.name = "held_item"
	#_held_item_remote.update_scale = false
	#_held_item_remote.update_rotation = true
	#_held_item_remote.update_position = true
	#_held_item_remote.global_position = _held_item.global_position
	#_held_item_remote.global_basis = _held_item.global_basis
	#_held_item_remote.remote_path = _held_item.get_path()
	
	#UTween.parallel(self, {
		#"_held_item_remote:position": Vector3(0.2, -0.2, -0.2),
		#"_held_item_remote:basis": Basis.IDENTITY
	#}, 0.1)

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

func _controlled(con: Controller) -> void:
	super(con)
	
	#agent.interactive_detector.visible_changed.connect(agent.interactive_changed.emit)
	controller.view_state_changed.connect(_view_state_changed)
	controller.show_widget(&"compass_markers")
	controller.show_widget(&"screen_space_markers")
	controller.show_widget(&"toast_manager")
	controller.show_widget(&"world_time")
	_interactive_hud = controller.show_widget(&"interaction_label")
	_interactive_hud.set_agent(self)
	_view_state_changed()

func _uncontrolled(con: Controller) -> void:
	super(con)
	
	_interactive_hud.close()
	_interactive_hud = null
	#agent.interactive_detector.visible_changed.disconnect(agent.interactive_changed.emit)
	controller.view_state_changed.disconnect(_view_state_changed)
	controller.hide_widget(&"compass_markers")
	controller.hide_widget(&"screen_space_markers")
	controller.hide_widget(&"interaction_label")
	controller.hide_widget(&"world_time")
	controller.hide_widget(&"toast_manager")

func _view_state_changed():
	match controller.view_state:
		Controller.ViewState.FirstPerson:
			Global.wait(0.35, controller.show_fps_viewport)
			await controller.pawn_camera.set_first_person()
			%model.visible = false
		Controller.ViewState.ThirdPerson:
			controller.hide_fps_viewport()
			controller.pawn_camera.set_third_person()
			%model.visible = true

func tell_npc(method: StringName, ...args) -> void:
	for npc in Global.get_tree().get_nodes_in_group(&"npc"):
		if npc != get_controller().pawn:
			npc.callv(method, args)

func _update_as_controlled(delta: float) -> void:
	if is_action_pressed(&"quick_equip_menu"):
		controller.show_widget(&"menu", { choices=[
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
		controller.toggle_widget(Assets.WIDGET_QUEST_LOG)
	
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
	if controller.is_third_person():
		var pos := interactive_detector.global_position
		inter = interactive_detector.get_nearest(pos)
	elif controller.is_first_person():
		inter = interactive_detector.get_nearest(looking_at)
	
	if inter != _interactive:
		if _interactive:
			_interactive.highlight = Interactive.Highlight.NONE
		_interactive = inter
		if _interactive:
			_interactive.highlight = Interactive.Highlight.FOCUSED
	
	var input_dir := controller.get_move_vector_camera()
	var cam: Camera3D = controller.pawn_camera.camera
	
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
