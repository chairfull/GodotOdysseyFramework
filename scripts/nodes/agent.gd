class_name Agent extends Controllable

signal damage_dealt(info: DamageInfo)
signal damage_taken(info: DamageInfo)
signal jumped() ## Called after jumping.
signal landed(meters: float) ## Called when hitting the floor.
signal prone_state_changed()
signal looked_at(pos: Vector3)
signal head_looked_at(pos: Vector3)
signal head_looking_amount_changed(amount: float)
signal focus_started()
signal focus_stopped()
signal interactive_changed()
@warning_ignore("unused_signal")
signal trigger_animation(anim: StringName)

enum ProneState { Stand, Crouch, Kneel, Crawl }

@onready var damageable: Damageable = %damageable
@onready var ray_coyote: RayCast3D = $ray_coyote
@onready var interactive_node: Interactive = %interactive
@onready var node_direction: Node3D = %direction
@onready var interactive_detector: Detector = %interact
@onready var node_seeing: Detector = %seeing
@onready var node_hearing: Detector = %hearing
@onready var nav_agent: NavigationAgent3D = %nav_agent

@export var flow_script: FlowScript
@export_range(-180, 180, 0.01, "radians_as_degrees") var direction: float: get=get_direction, set=set_direction
@export var char_id: StringName
var char_info: CharInfo:
	get: return null if not char_id else State.find_char(char_id)
var movement := Vector2.ZERO
var body: CharacterBody3D = (self as Object as CharacterBody3D)
var _equipped: Dictionary[StringName, ItemNode]
var prone_state := ProneState.Stand:
	set(ps):
		if prone_state == ps: return
		prone_state = ps
		prone_state_changed.emit()
var _next_prone_state := ProneState.Stand
var _focusing := false
var _interactive: Interactive: ## Interactive we are looking at.
	set(inter):
		_interactive = inter
		interactive_changed.emit()
var _interacting: Interactive ## Interactive we are interacting with.
var _jumping := false
var _jump_cancel := false
var _sprinting := false
var _was_in_air := false
var _last_position: Vector3
var _held_item: ItemNode
var _held_item_remote: RemoteTransform3D
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

var speed_stand := 3.0
var speed_crouch := 1.0
var speed_crawl := 0.25

var visual: PackedScene ## TODO:
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force := 6.0

var _footstep_time := 0.0

func _ready() -> void:
	super()
	fix_direction()
	if %nav_agent:
		(%nav_agent as NavigationAgent3D).navigation_finished.connect(func(): movement = Vector2.ZERO)
	if %damageable:
		(%damageable as Damageable).damaged.connect(damage_taken.emit)
	if %interactive:
		interactive_detector.ignore.append(%interactive)
		%interactive.interacted.connect(_interacted)

func _physics_process(delta: float) -> void:
	#if frozen: return
	
	var move_speed := 1.0
	match prone_state:
		ProneState.Stand: move_speed = speed_stand
		ProneState.Crouch: move_speed = speed_crouch
		ProneState.Crawl: move_speed = speed_crawl
	if _sprinting:
		move_speed *= 2.0
	
	#if not nav_agent.is_navigation_finished():
		#var curr_pos := global_position
		#var next_pos := nav_agent.get_next_path_position()
		#var dir := next_pos - curr_pos
		#dir.y = 0.0
		#dir = dir.normalized()
		#movement.x = dir.x
		#movement.y = dir.z
		#var ang := Vector2(curr_pos.x, curr_pos.z).direction_to(Vector2(next_pos.x, next_pos.z))
		#direction = lerp_angle(direction, atan2(-ang.y, ang.x), delta * 10.0)
	
	#if name == "player":
		#prints(_jumping, _jump_cancel)
	
	var vel := Vector3(movement.x * move_speed, body.velocity.y, movement.y * move_speed)
	if _jump_cancel:
		_jumping = false
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
			if col and "physics_material_override" in col and col.physics_material_override is SurfaceMaterial:
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

func _interacted(with: Pawn, form: Interactive.Form) -> void:
	if flow_script:
		Cinema.queue(flow_script)
	else:
		prints(with.name, "interacted with", name, "FORM:", form)

func fix_direction() -> void:
	# Transfer rotation to proper node.
	%direction.rotation.y = rotation.y
	rotation.y = 0

func equip(item: ItemNode, slot: StringName = &""):
	_equipped[slot] = item
	var parent := get_node_or_null("%" + str(slot))
	if parent != null:
		if item.get_parent() == null:
			parent.add_child(item)
		else:
			item.reparent(parent)
	item.damage_dealt.connect(damage_dealt.emit)

func unequip_slot(slot: StringName = &""):
	if not slot in _equipped: return
	var item: ItemNode = _equipped[slot]
	item.damage_dealt.disconnect(damage_dealt.emit)
	_equipped.erase(slot)

func get_direction() -> float: return %direction.rotation.y
func set_direction(dir: float): %direction.rotation.y = dir

func focus_start():
	_focusing = true
	focus_started.emit()

func focus_stop():
	_focusing = false
	focus_stopped.emit()

func interact_start(with: Pawn) -> bool:
	if _interactive:#interactive_detector.is_detecting():
		_interacting = _interactive#interactive_detector.get_nearest() as Interactive
		_interacting.interact(with)
		return true
	return false

func interact_stop(with: Pawn) -> bool:
	if _interacting:
		_interacting.cancel(with)
		_interacting = null
		return true
	return false

func sprint_start():
	_sprinting = true

func sprint_stop():
	_sprinting = false

func jump_start():
	_jumping = true

func jump_stop():
	_jump_cancel = true

func fire_start() -> bool:
	if not _held_item: return false
	return _held_item.item._node_use(_held_item)

func fire_stop() -> bool: return true

func reload_start() -> bool:
	if not _held_item: return false
	return _held_item.item._node_reload(_held_item)

func reload_stop() -> bool: return true

func stand(): prone_state = ProneState.Stand
func crouch(): prone_state = ProneState.Crouch
func crawl(): prone_state = ProneState.Crawl

func is_focusing() -> bool: return _focusing
func is_crouching() -> bool: return prone_state == ProneState.Crouch or _next_prone_state == ProneState.Crouch
func is_crawling() -> bool: return prone_state == ProneState.Crawl or _next_prone_state == ProneState.Crawl
func is_standing() -> bool: return prone_state == ProneState.Stand or _next_prone_state == ProneState.Stand

func freeze() -> void:
	body.collision_mask = 0
	set_process(false)
	set_physics_process(false)

func unfreeze() -> void:
	body.collision_mask = 1
	set_process(true)
	set_physics_process(true)

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
