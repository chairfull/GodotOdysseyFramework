```gd
# res://scripts/nodes/pawn.gd
class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal posessed(con: Controller)
signal unposessed(con: Controller)
signal rider_mounted(r: Pawn)
signal rider_unmounted(r: Pawn)
signal mounted(ride: Pawn)
signal unmounted(ride: Pawn)
signal froze()
signal unfroze()

@export_group("Mount")
@export var rider_interact: Interactive ## Interactive that takes control.
@export var rider: Pawn: set=set_rider ## Set internally. TODO: Set from scene.
var frozen := false: set=set_frozen
var controller: Controller
var player_controller: ControllerPlayer:
	get: return controller
var _mount: Pawn: set=set_mount ## What we are riding.

func _init() -> void:
	add_to_group(&"Pawn")

func _ready() -> void:
	if name == "player":
		Controllers.player.set_pawn.call_deferred(self)
	elif name.begins_with("npc_"):
		Controllers.get_or_create_npc(name).set_pawn.call_deferred(self)
	
	if rider_interact:
		rider_interact.interacted.connect(_rider_interacted)
	else:
		push_warning("No rider_interact set for %s." % self)

func _rider_interacted(pawn: Pawn, _form: Interactive.Form):
	set_rider(pawn)

func get_controller_recursive() -> Controller:
	return rider.controller if rider else controller

func _posessed(con: Controller) -> void:
	print("[%s controls %s]" % [con.name, name])
	controller = con
	posessed.emit(con)

func _unposessed() -> void:
	unposessed.emit(controller)
	controller = null

func is_controlled() -> bool: return controller != null
func is_player_controlled() -> bool: return controller is ControllerPlayer
func is_ridden() -> bool: return rider != null
func is_mounted() -> bool: return _mount != null

func set_frozen(f):
	if frozen == f: return
	if frozen: unfroze.emit()
	frozen = f
	if frozen: froze.emit()

func set_mount(m: Pawn):
	if _mount == m: return
	if _mount: unmounted.emit(_mount)
	_mount = m
	if _mount: mounted.emit(_mount)

func set_rider(r: Pawn):
	if rider == r: return
	if rider: # Unmount old.
		# Take back control.
		if is_controlled():
			controller.set_pawn.call_deferred(rider)
		rider._mount = null
		rider_unmounted.emit(rider)
	rider = r
	if rider: # Remound new.
		# Give control to rider.
		if rider.is_controlled():
			rider.controller.set_pawn.call_deferred(self)
		rider._mount = self
		rider_mounted.emit(rider)
	
```

```gd
# res://scripts/states/pawn_state.gd
@icon("res://addons/odyssey/icons/control.svg")
class_name PawnState extends Node3D
## Child of Pawn.

@export var dummy := false
@export var pawn: Pawn:
	get: return pawn if pawn else get_parent()
@export var hud: StringName ## If player, scene added to hud.
@export var cinematic: StringName ## Cinematic to play.
var _enabled := false
var _controller: Controller

@export_group("Process", "process_")
@export var process_on_posessed := true
@export var process_on_rider := false ## Other riding me.
@export var process_on_mounted := false ## I'm riding other.
@export var process_if_player := true
@export var process_if_npc := false

@export_group("Rider")
@export var freeze_rider := true
@export var reparent_rider := true
@export var animate_rider := true
@export var animation_enter := &"Sitting_Idle"
@export var animation_exit := &"Standing"
@export var tween_position := true ## Animation controllable position.
@export var tween_rotation := true ## A
@export var tween_time := 0.5
var _rider: Pawn
var _rider_last_parent: Node
var _froze_rider: bool

func _ready() -> void:
	if Engine.is_editor_hint(): return
	process_mode = Node.PROCESS_MODE_DISABLED
	if dummy: return
	if not pawn: return
	pawn.froze.connect(_frozen)
	pawn.unfroze.connect(_unfrozen)
	if process_on_rider:
		pawn.rider_mounted.connect(_rider_mounted)
		pawn.rider_unmounted.connect(_rider_unmounted)
	if process_on_mounted:
		pawn.mounted.connect(_mounted)
		pawn.unmounted.connect(_unmounted)
	if process_on_posessed:
		pawn.posessed.connect(_posessed)
		pawn.unposessed.connect(_unposessed)

func _frozen():
	process_mode = Node.PROCESS_MODE_DISABLED
	_froze_rider = true

func _unfrozen():
	if _enabled:
		process_mode = Node.PROCESS_MODE_INHERIT
		_froze_rider = false

func is_action_pressed(action: StringName, allow_echo := false, exact_match := false) -> bool:
	return get_player_controller().is_action_pressed(action, allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false):
	return get_player_controller().is_action_released(action, exact_match)

func handle_input():
	get_viewport().set_input_as_handled()

# For when something mounts us
func _can_enable_as_vehicle(rider: Pawn) -> bool:
	if process_if_player and not rider.is_player_controlled(): return false
	if process_if_npc and rider.is_player_controlled(): return false
	return true

# For when we mount something
func _can_enable_as_rider() -> bool:
	var con := pawn.get_controller_recursive()
	if process_if_player and not con.is_player(): return false
	if process_if_npc and con.is_player(): return false
	return true

func _can_enable_as_posessor(con: Controller) -> bool:
	if process_if_player and not con.is_player(): return false
	if process_if_npc and con.is_player(): return false
	return true

func kick_rider():
	pawn.set_rider(null)

func _rider_mounted(rider: Pawn) -> void:
	if not _can_enable_as_vehicle(rider): return
	
	_rider = rider
	_controller = rider.controller
	
	if reparent_rider:
		_rider_last_parent = _rider.get_parent()
		_rider.reparent(self)
	
	_enable()

func _rider_unmounted(rider: Pawn) -> void:
	if _rider != rider: return
	print("Rider unmounted...")
	
	if _rider_last_parent:
		_rider.reparent(_rider_last_parent)
		_rider_last_parent = null
	
	_disable()
	
	_rider = null
	_controller = null

func _mounted(_mount: Pawn) -> void:
	if _can_enable_as_rider():
		_enable()

func _unmounted(_mount: Pawn) -> void:
	if _enabled and _can_enable_as_rider():
		_disable()

func _posessed(con: Controller):
	if not _enabled and _can_enable_as_posessor(con):
		_controller = con
		_enable()

func _unposessed(con: Controller):
	if _enabled and _controller == con:
		_disable()
		_controller = null

func _enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	_enabled = true
	
	if pawn.is_player_controlled():
		if hud:
			pawn.player_controller.show_hud(hud)
	
	if freeze_rider and _rider:
		_rider.frozen = true
		_froze_rider = true
	
	if _rider is Humanoid:
		var human: Humanoid = _rider as Humanoid
		if animate_rider and animation_enter:
			human.trigger_animation.emit(animation_enter)
		if tween_position or tween_rotation:
			human.fix_direction()
			var dir_from := human.rotation.y
			var dir_to := 0.0
			var pos_from := human.position
			var pos_to := Vector3.ZERO
			UTween.interp(human, 
				func(x: float):
					if tween_rotation:
						human.direction = lerp_angle(dir_from, dir_to, x)
					if tween_position:
						human.position = lerp(pos_from, pos_to, x),
				tween_time)
			print("Rotate out...")

func _disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	_enabled = false
	
	if is_player():
		if hud:
			get_player_controller().hide_hud(hud)
	
	if _rider is Humanoid:
		var human: Humanoid = _rider as Humanoid
		human.fix_direction()
		if animate_rider and animation_exit:
			human.trigger_animation.emit(animation_exit)
			if _froze_rider:
				Global.wait(0.8, func():
					human.frozen = false
					_froze_rider = false
					) ## Wait a smidge for animation to play.
		elif _froze_rider:
			human.frozen = false
			_froze_rider = false
	
	elif _froze_rider and _rider:
		_rider.frozen = false
		_froze_rider = false

func get_controller() -> Controller:
	return _controller#pawn.get_controller_recursive()

func get_player_controller() -> ControllerPlayer:
	return get_controller() as ControllerPlayer

func is_player() -> bool:
	var con := get_controller()
	return con and con.is_player()

func is_first_person() -> bool:
	return get_player_controller().view_state == ControllerPlayer.ViewState.FirstPerson

func is_third_person() -> bool:
	return get_player_controller().view_state == ControllerPlayer.ViewState.ThirdPerson

func _get_configuration_warnings() -> PackedStringArray:
	if pawn == null and not get_parent() is Pawn:
		return ["No pawn reference or Pawn parent."]
	return []
```

```gd
# res://scripts/nodes/humanoid.gd
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
	if controller.is_player():
		interactive_detector.visible_changed.connect(interactive_changed.emit)

func _unposessed() -> void:
	if controller.is_player():
		interactive_detector.visible_changed.disconnect(interactive_changed.emit)
	super()

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
```

```gd
# res://scripts/nodes/vehicle.gd
class_name Vehicle extends Pawn

var brake := false ## 
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)
var throttle: float:
	get: return move.y
	set(t): move.y = t
var steering: float:
	get: return move.x
	set(s): move.x = s

func honk():
	pass

func brake_start(): brake = true
func brake_end(): brake = false
```

```gd
# res://scripts/states/pstate_turret_keyboard.gd
class_name PStateTurret extends PawnState

var _angle := 0.0

func _unhandled_input(event: InputEvent) -> void:
	get_player_controller()._event = event
	if is_action_pressed(&"exit"):
		kick_rider()
		handle_input()

func _process(delta: float) -> void:
	var vec := get_controller().get_move_vector()
	_angle -= vec.x * 2.0 * delta
	pawn.rotation.y = lerp_angle(pawn.rotation.y, _angle, delta * 10.0)
```

```gd
# res://scripts/states/pstate_humanoid_keyboard.gd
class_name PStateHumanoidKeyboard extends PawnState

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
	var player := get_player_controller()
	player._event = event
	
	if is_action_pressed(&"exit"):
		pawn.rider = null
		handle_input()
	
	if is_action_pressed(&"toggle_quest_log"):
		get_player_controller().toggle_hud(&"quest_log")
	
	elif is_action_pressed(&"interact"):
		if humanoid.interact_start(_interactive):
			get_viewport().set_input_as_handled()
	elif is_action_released(&"interact"):
		if humanoid.interact_stop():
			get_viewport().set_input_as_handled()
	
	elif is_action_pressed(&"fire"):
		if humanoid.fire():
			get_viewport().set_input_as_handled()
	elif is_action_pressed(&"reload"):
		if humanoid.reload():
			get_viewport().set_input_as_handled()
	elif is_action_pressed(&"jump"):
		if humanoid.prone_state in [Humanoid.ProneState.Crouch, Humanoid.ProneState.Crawl]:
			humanoid.stand()
		else:
			humanoid.jump_start()
		get_viewport().set_input_as_handled()
	elif is_action_released(&"jump"):
		if humanoid.jump_end():
			get_viewport().set_input_as_handled()
	elif is_action_pressed(&"drop"):
		if humanoid.drop():
			get_viewport().set_input_as_handled()
	
	elif is_action_pressed(&"aim"):
		humanoid.focus()
		camera.focus()
		get_viewport().set_input_as_handled()
	elif is_action_released(&"aim"):
		humanoid.unfocus()
		camera.unfocus()
		get_viewport().set_input_as_handled()
		
	elif is_action_pressed(&"crouch", false, true):
		_crouch_held = true
		if humanoid.is_standing():
			humanoid.crouch()
		elif humanoid.is_crawling():
			humanoid.crouch()
		get_viewport().set_input_as_handled()
	elif is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		if humanoid.is_crouching():
			humanoid.stand()
		get_viewport().set_input_as_handled()
	
	elif is_action_pressed(&"sprint"):
		if humanoid.sprint_start():
			get_viewport().set_input_as_handled()
	elif is_action_released(&"sprint"):
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
```

