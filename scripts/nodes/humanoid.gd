class_name Humanoid extends Agent

func pickup(_item_node: ItemNode):
	print("TODO: PICKUP")
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
