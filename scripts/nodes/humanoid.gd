class_name Humanoid extends Agent

signal jumped() ## Called after jumping.
signal landed(meters: float) ## Called when hitting the floor.
signal prone_state_changed()
signal looked_at(pos: Vector3)
signal head_looked_at(pos: Vector3)
signal head_looking_amount_changed(amount: float)
signal interactive_changed()
@warning_ignore("unused_signal")
signal trigger_animation(anim: StringName)

enum ProneState { Stand, Crouch, Kneel, Crawl }

@onready var damageable: Damageable = %damageable
@onready var ray_coyote: RayCast3D = $ray_coyote
var speed_stand := 3.0
var speed_crouch := 1.0
var speed_crawl := 0.25
var prone_state := ProneState.Stand
var _next_prone_state := ProneState.Stand
var visual: PackedScene ## TODO:
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force := 6.0
var looking_at: Vector3:
	set(at):
		looking_at = at
		looked_at.emit(at)
		%cursor.global_position = at
var head_looking_at: Vector3:
	set(at):
		head_looking_at = at
		head_looked_at.emit(at)
var head_looking_amount: float:
	set(amt):
		head_looking_amount = amt
		head_looking_amount_changed.emit(amt)
var _jumping := false
var _jump_cancel := false
var _sprinting := false
var _was_in_air := false
var _last_position: Vector3
var _held_item: ItemNode
var _held_item_remote: RemoteTransform3D
var _focusing := false
var _interacting: Interactive
var _footstep_time := 0.0

func _posessed(con: Controller) -> void:
	super(con)
	if con.is_player():
		interactive_detector.visible_changed.connect(interactive_changed.emit)

func _unposessed(con: Controller) -> void:
	super(con)
	if con.is_player():
		interactive_detector.visible_changed.disconnect(interactive_changed.emit)

func _physics_process(delta: float) -> void:
	if frozen: return
	
	var move_speed := 1.0
	match prone_state:
		ProneState.Stand: move_speed = speed_stand
		ProneState.Crouch: move_speed = speed_crouch
		ProneState.Crawl: move_speed = speed_crawl
	if _sprinting:
		move_speed *= 2.0
	
	if not nav_agent.is_navigation_finished():
		var curr_pos := global_position
		var next_pos := nav_agent.get_next_path_position()
		var dir := next_pos - curr_pos
		dir.y = 0.0
		dir = dir.normalized()
		movement.x = dir.x
		movement.y = dir.z
		var ang := Vector2(curr_pos.x, curr_pos.z).direction_to(Vector2(next_pos.x, next_pos.z))
		direction = lerp_angle(direction, atan2(-ang.y, ang.x), delta * 10.0)
	
	var vel := Vector3(movement.x * move_speed, body.velocity.y, movement.y * move_speed)
	if _jump_cancel:
		_jump_cancel = false
		vel.y /= 2.0
	elif _jumping and (body.is_on_floor() or Cheats.infinite_jumping):
		_jumping = false
		vel.y = jump_force
		jumped.emit()
	elif body.is_on_floor():
		vel.y = -0.01
	else:
		vel.y -= gravity * delta
		
	if body.is_on_floor():
		_footstep_time += Vector2(vel.x, vel.z).length() * delta
		if _footstep_time > 1.0:
			_footstep_time -= 1.0
			
			
			var col: Node = %ray_coyote.get_collider()
			if "physics_material_override" in col and col.physics_material_override is SurfaceMaterial:
				var mat: SurfaceMaterial = col.physics_material_override
				var id: String
				match mat.resource_path:
					"res://assets/surfaces/grass.tres":
						id = "grass_%s" % randi_range(1, 15)
					"res://assets/surfaces/concrete.tres":
						id = "concrete_%s" % randi_range(1, 15)
					"res://assets/surfaces/wood.tres":
						id = "wood_%s" % randi_range(1, 15)
					"res://assets/surfaces/carpet.tres":
						id = "carpet_%s" % randi_range(1, 15)
				var audio: AudioStreamPlayer3D = Assets.create_audio_player(id)
				add_child(audio)
				audio.play(0.1)
				audio.finished.connect(func():
					audio.queue_free()
					print("removed"))
		
		if _was_in_air:
			_was_in_air = false
			landed.emit(1.0) # TODO: Meters fallen.
	
	_was_in_air = not body.is_on_floor()
	
	body.velocity = vel
	body.move_and_slide()
	_last_position = body.global_position

func move_to(pos: Vector3):
	nav_agent.set_target_position(pos)

func get_interactives() -> Array[Interactive]:
	var out: Array[Interactive]
	out.assign(interactive_detector._visible)
	return out

func interact_start(inter: Interactive) -> bool:
	if inter:#interactive_detector.is_detecting():
		_interacting = inter#interactive_detector.get_nearest() as Interactive
		_interacting.interact(self)
		return true
	return false

func interact_stop() -> bool:
	if _interacting:
		_interacting.cancel(self)
		_interacting = null
		return true
	return false

func fire() -> bool:
	if not _held_item: return false
	return _held_item.item._node_use(_held_item)

func reload() -> bool:
	if not _held_item: return false
	return _held_item.item._node_reload(_held_item)

func pickup(item_node: ItemNode):
	var dummy := MeshInstance3D.new()
	get_tree().current_scene.add_child(dummy)
	dummy.mesh = BoxMesh.new()
	dummy.mesh.size = Vector3.ONE * .2
	dummy.layers = 1<<1
	var camera := player_controller.camera_master.target.get_parent()
	var remote := RemoteTransform3D.new()
	camera.add_child(remote)
	remote.remote_path = dummy.get_path()
	remote.position = Vector3(-0.2, -0.2, -0.2)
	
	_held_item = item_node
	_held_item.item._node_equipped(_held_item)
	_held_item.mount = self
	_held_item.process_mode = Node.PROCESS_MODE_DISABLED
	
	_held_item_remote = RemoteTransform3D.new()
	camera.add_child(_held_item_remote)
	_held_item_remote.name = "held_item"
	_held_item_remote.update_scale = false
	_held_item_remote.update_rotation = true
	_held_item_remote.update_position = true
	_held_item_remote.global_position = _held_item.global_position
	_held_item_remote.global_basis = _held_item.global_basis
	_held_item_remote.remote_path = _held_item.get_path()
	#_held_item_last_parent = item_node.get_parent()
	#_held_item.reparent(%head)
	
	UTween.parallel(self, {
		"_held_item_remote:position": Vector3(0.2, -0.2, -0.2),
		"_held_item_remote:basis": Basis.IDENTITY
	}, 0.1)

func drop() -> bool:
	if not _held_item: return false
	if _held_item.item._node_unequipped(_held_item):
		var trans := _held_item.global_transform
		var fwd: Vector3 = -%head.global_basis.z
		trans.origin += fwd * .2
		%head.remove_child(_held_item_remote)
		_held_item_remote.queue_free()
		_held_item_remote = null
		#_held_item.reparent(_held_item_last_parent)
		_held_item.mount = null
		_held_item.process_mode = Node.PROCESS_MODE_INHERIT
		_held_item.reset_state(trans)
		_held_item.apply_central_impulse(fwd * 3.0)
		_held_item = null
		#_held_item_last_parent = null
		return true
	return false

func sprint_start():
	_sprinting = true

func sprint_end():
	_sprinting = false

func jump_start():
	_jumping = true

func jump_end():
	_jump_cancel = true

func is_focusing() -> bool: return _focusing
func is_crouching() -> bool: return prone_state == ProneState.Crouch or _next_prone_state == ProneState.Crouch
func is_crawling() -> bool: return prone_state == ProneState.Crawl or _next_prone_state == ProneState.Crawl
func is_standing() -> bool: return prone_state == ProneState.Stand or _next_prone_state == ProneState.Stand

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

func focus():
	_focusing = true

func unfocus():
	_focusing = false
