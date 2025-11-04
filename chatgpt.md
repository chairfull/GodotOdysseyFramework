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

@export var player: bool: ## The main controllable of the main controller.
	get: return is_controlled() and controller == Controllers.player
	set(c):
		if c:
			take_control.call_deferred()
		elif is_controlled():
			Controllers.player.controllable = null

@export_group("Mount")
@export var rider_interact: Interactive ## Interactive that takes control.
@export var rider: Pawn: set=set_rider ## Set internally. TODO: Set from scene.
var frozen := false: set=set_frozen
var controller: Controller: set=set_controller
var player_controller: ControllerPlayer:
	get: return controller
var _mount: Pawn: set=set_mount ## What we are riding.

func _init() -> void:
	add_to_group(&"Pawn")

func _ready() -> void:
	if rider_interact:
		rider_interact.interacted.connect(_rider_interacted)
	else:
		push_warning("No rider_interact set for %s." % self)

func _rider_interacted(pawn: Pawn, _form: Interactive.Form):
	set_rider(pawn)

func set_controller(c: Controller):
	if controller == c: return
	if controller: _unposessed(controller)
	controller = c
	if controller: _posessed(controller)

func get_controller_recursive() -> Controller:
	return rider.controller if rider else controller

func take_control(c: Controller = null):
	(c if c else Controllers.player).pawn = self

func _posessed(con: Controller) -> void:
	print("[%s controls %s]" % [controller.name, name])
	posessed.emit(con)

func _unposessed(con: Controller) -> void:
	unposessed.emit(con)

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
	if rider:
		# Take back control.
		if rider.is_controlled():
			rider.controller.set_pawn(self)
		rider._mount = null
		rider_unmounted.emit(rider)
	rider = r
	if rider:
		# Give control to rider.
		if is_controlled():
			controller.set_pawn(rider)
		rider._mount = self
		rider_mounted.emit(rider)
	
```

```gd
# res://scripts/nodes/controller.gd
class_name Controller extends Node

@export var index := 0 ## For multiplayer.
@export var pawn: Pawn: set=set_pawn

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func set_pawn(target: Pawn):
	if pawn == target: return
	if pawn:
		pawn.set_controller.call_deferred(null)
		_ended()
	pawn = target
	pawn.set_controller.call_deferred(self)
	_started.call_deferred()

func is_player() -> bool:
	return self is ControllerPlayer

func get_move_vector() -> Vector2:
	return Vector2.ZERO

func _started():
	pass

func _ended():
	pass
```

```gd
# res://scripts/nodes/interactive.gd
@tool @icon("res://addons/odyssey/icons/interactive.svg")
class_name Interactive extends Area3D

signal toggled()
signal toggled_on()
signal toggled_off()
signal charge_started()
signal charge_percent(amnt: float)
signal charge_ended()
signal interacted(pawn: Pawn, form: Form)
signal highlight_changed()

enum Form { INTERACT, ENTERED, EXITED }
enum ToggleIterationMode { FORWARD, BACKWARD, RANDOM }
enum Highlight { NONE, FOCUSED }

@export var label: String = "Interact"
@export var label_world_space_offset := Vector3.ZERO
@export var humanoid_lookat_offset := Vector3.ZERO
var can_interact := func(_pawn: Pawn): return true

@export var disabled := false:
	get: return not monitorable
	set(d): monitorable = not d

@export var highlight := Highlight.NONE:
	set(h):
		highlight = h
		highlight_changed.emit()

@export_group("Toggleable")
@export var toggleable := false:
	get: return toggle_states != 0
	set(t):
		if t:
			if toggle_states == 0:
				toggle_states = 1
		else:
			toggle_states = 0
@export var on := false:
	get: return toggle_state != 0
	set(o):
		if o:
			if toggle_state == 0:
				toggle_state = 1
		else:
			toggle_state = 0
@export var toggle_states := 0 ## 0 == no toggle. 1 = on/off.
@export var toggle_state := 0:
	set(t):
		toggle_state = t
		if toggle_state == 0:
			toggled_off.emit()
		else:
			toggled_on.emit()
		toggled.emit()
@export var toggle_labels: PackedStringArray = ["Interact [Turn Off]", "Interact [Turn On]"]
@export var toggle_iteration_mode := ToggleIterationMode.FORWARD ## Only when toggle_states > 0.
@export var toggle_iteration_loop := true ## Loop or clamp.
var toggle_count := 0 ## How many times interactive was toggled.
var _toggle_next := 0 ## Next state we will enter. Needed for setting accurate labels.

@export_group("Chargeable")
@export var chargeable := false: ## Based on charge_time state. 0.0 == false.
	get: return charge_time != 0.0
	set(c):
		if c:
			if charge_time == 0.0:
				charge_time = 1.0
		else:
			charge_time = 0.0
@export var charge_time := 0.0 ## Seconds to hold interact down.
@export var charge_instant_reset := true
@export var charge_increase_scale := 1.0
@export var charge_decrease_scale := 1.0
var _charging := false
var _charge_time := 0.0
var _charge_pawn: Pawn
var _charge_form: Form

@export_group("Enterable & Exitable")
@export var interact_on_enter := false ## Interaction occurs when object enters.
@export var interact_on_exit := false ## Interaction occurs when object leaves.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var ioe_expression: String ## Expression to test if interact_on_enter == true.
@export var ioe_delay := 0.1 ## Slight time delay, so it's not instant. If no longer inside, this cancels interaction.
@export var ioe_scene: PackedScene ## A scene to swap to if interaction occurs.

func _init() -> void:
	monitoring = false
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(10, true)

func _ready() -> void:
	body_entered.connect(_entered)
	body_exited.connect(_exited)
	set_process(false)

func _entered(body: Node3D):
	if not interact_on_enter: return
	if ioe_delay == 0:
		interact(body, Form.ENTERED)
	else:
		Global.wait(ioe_delay, func():
			if body in get_overlapping_bodies():
				interact(body, Form.ENTERED))

func _exited(body: Node3D):
	if not interact_on_exit: return
	if ioe_delay == 0:
		interact(body, Form.EXITED)
	else:
		Global.wait(ioe_delay, func():
			if not body in get_overlapping_bodies():
				interact(body, Form.EXITED))

func interact(pawn: Pawn, form := Form.INTERACT):
	if not can_interact.call(pawn): return
	if charge_time == 0:
		_interacted(pawn, form)
	else:
		_charging = true
		_charge_pawn = pawn
		_charge_form = form
		charge_started.emit()
		set_process(true)

## Cancel the interaction.
## Only used when hold_time != 0.0
func cancel(pawn: Pawn):
	if _charging and pawn == _charge_pawn:
		_charging = false
		_charge_pawn = null
		charge_ended.emit()

func _process(delta: float) -> void:
	if _charging:
		_charge_time += delta * charge_increase_scale
		if _charge_time >= charge_time:
			set_process(false)
			_charge_time = charge_time
			_interacted(_charge_pawn, _charge_form)
			_charge_pawn = null
	else:
		if charge_instant_reset:
			_charge_time = 0.0
		else:
			_charge_time -= delta * charge_decrease_scale
		
		if _charge_time <= 0.0:
			set_process(false)
			_charge_time = 0.0
	
	var percent := remap(_charge_time, 0.0, charge_time, 0.0, 1.0)
	charge_percent.emit(percent)
	print(percent)

func _interacted(pawn: Pawn, form: Form) -> void:
	interacted.emit(pawn, form)
	
	if toggleable:
		toggle_count += 1
		toggle_state = _toggle_next
		match toggle_iteration_mode:
			ToggleIterationMode.FORWARD: _toggle_next += 1
			ToggleIterationMode.BACKWARD: _toggle_next -= 1
			ToggleIterationMode.RANDOM: _toggle_next = randi() % toggle_states
			
		if toggle_iteration_loop:
			_toggle_next = wrapi(_toggle_next, 0, toggle_state)
		else:
			_toggle_next = clampi(_toggle_next, 0, toggle_states)
		
		# Label is what happens *next*
		label = toggle_labels[_toggle_next]
	
	if interact_on_enter and ioe_scene:
		get_tree().change_scene_to_packed(ioe_scene)
```

```gd
# res://scripts/states/pawn_state.gd
@icon("res://addons/odyssey/icons/control.svg")
class_name PawnState extends Node3D
## Child of Pawn.

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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"exit"):
		pawn.rider = null
		get_viewport().set_input_as_handled()

func _can_enable(p: Pawn) -> bool:
	if process_if_player and not p.is_player_controlled():
		return false
	if process_if_npc and p.is_player_controlled():
		return false
	return true
	
func _rider_mounted(rider: Pawn) -> void:
	if _can_enable(rider):
		_rider = rider
		
		if reparent_rider:
			_rider_last_parent = _rider.get_parent()
			_rider.reparent(self)
		
		_enable()

func _rider_unmounted(rider: Pawn) -> void:
	if _rider == rider:
		_disable()
		
		if _rider_last_parent:
			_rider.reparent(_rider_last_parent)
			_rider_last_parent = null
		
		_rider = null

func _mounted(_mount: Pawn) -> void:
	if _can_enable(pawn):
		_enable()

func _unmounted(_mount: Pawn) -> void:
	if _enabled:
		_disable()

func _posessed(con: Controller):
	if _can_enable(pawn):
		_controller = con
		_enable()

func _unposessed(con: Controller):
	if _controller == con:
		_disable()
		_controller = null

func _enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	_enabled = true
	
	if pawn.is_player_controlled():
		if hud:
			pawn.player_controller.show_hud(hud)
	
	if freeze_rider and _rider is Agent:
		_rider.frozen = true
		_froze_rider = true
	
	if _rider is Humanoid:
		var human: Humanoid = _rider as Humanoid
		if animate_rider and animation_enter:
			human.trigger_animation.emit(animation_enter)
		if tween_position or tween_rotation:
			var dir_from := human.direction
			var dir_to := pawn.global_rotation.y
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
	
	if pawn.is_player_controlled():
		if hud:
			pawn.player_controller.hide_hud(hud)
	
	if _rider is Humanoid:
		var human: Humanoid = _rider as Humanoid
		human.fix_direction()
		human.direction = pawn.global_rotation.y
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
	
	elif _froze_rider:
		_rider.frozen = false
		_froze_rider = false

func get_controller() -> Controller:
	return pawn.get_controller_recursive()

func get_player_controller() -> ControllerPlayer:
	return get_controller() as ControllerPlayer

func is_player() -> bool:
	var con := get_controller()
	return con and con.is_player()

func is_first_person() -> bool:
	return pawn.player_controller.view_state == ControllerPlayer.ViewState.FirstPerson

func is_third_person() -> bool:
	return pawn.player_controller.view_state == ControllerPlayer.ViewState.ThirdPerson

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

func drop() -> bool:
	if not _held_item: return false
	if _held_item.item._node_unequipped(_held_item):
		_held_item.reparent(get_tree().current_scene)
		_held_item.mount = null
		_held_item = null
		return true
	return false

func pickup(item_node: ItemNode):
	_held_item = item_node
	item_node.reparent(%head)
	item_node.item._node_equipped(item_node)
	
	UTween.parallel(item_node, {
		"position": Vector3(0.2, -0.2, -0.2),
		"basis": Basis.IDENTITY
	}, 0.5)
	#if _tween_item: _tween_item.kill()
	#_tween_item = create_tween()
	#_tween_item.set_parallel()
	#_tween_item.set_trans(Tween.TRANS_BACK)
	#_tween_item.tween_property(item_node, "position", Vector3(0.2, -0.2, -0.2), 0.5)
	#_tween_item.tween_property(item_node, "basis", Basis.IDENTITY, 0.5)

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

