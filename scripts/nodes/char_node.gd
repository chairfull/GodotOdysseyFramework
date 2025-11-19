class_name CharNode extends Pawn

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
signal equipped(slot_id: StringName)
signal unequipped(slot_id: StringName)
@warning_ignore("unused_signal")
signal trigger_animation(anim: StringName)

enum ProneState { Stand, Crouch, Kneel, Crawl }

@onready var damageable: Damageable = %damageable
@onready var ray_coyote: RayCast3D = $ray_coyote
@onready var node_direction: Node3D = %direction
@onready var interactive_detector: Detector = %interact
@onready var eyes: Detector = %eyes
@onready var ears: Detector = %ears
@onready var nav_agent: NavigationAgent3D = %nav_agent

@export_range(-180, 180, 0.01, "radians_as_degrees") var direction: float: get=get_direction, set=set_direction
@export var id: StringName
@export var target: Node3D
@export var primary_equip_slot: StringName = &"right_hand"
var info: CharInfo:
	get: return null if not id else State.find_char(id)
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
#var _held_item: ItemNode
#var _held_item_remote: RemoteTransform3D
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
var _stuck_time := 0.0

func _ready() -> void:
	super()
	fix_direction()
	if %nav_agent:
		(%nav_agent as NavigationAgent3D).navigation_finished.connect(func(): movement = Vector2.ZERO)
	if %damageable:
		(%damageable as Damageable).damaged.connect(damage_taken.emit)
	if %interactive:
		interactive_detector.ignore.append(%interactive)
	
	nav_agent.velocity_computed.connect(_velocity_computed)

func _velocity_computed(safe_velocity: Vector3) -> void:
	if not nav_agent.avoidance_enabled: return
	body.velocity = safe_velocity
	body.move_and_slide()

func _controlled() -> void:
	super()
	nav_agent.avoidance_enabled = false
	eyes.enabled = false
	ears.enabled = false
	%debug.enabled = false

func _uncontrolled() -> void:
	super()
	_enable_ai.call_deferred()

func _enable_ai() -> void:
	nav_agent.avoidance_enabled = true
	eyes.enabled = true
	ears.enabled = true
	%debug.enabled = true

func lerp_direction(delta: float, speed := 10.0) -> void:
	#var ang := Vector2(curr_pos.x, curr_pos.z).direction_to(Vector2(next_pos.x, next_pos.z))
	#direction = lerp_angle(direction, atan2(-ang.y, ang.x), delta * 10.0)
	direction = lerp_angle(direction, atan2(movement.y, -movement.x) + PI * .5, delta * speed)

func move_to(at: Vector3) -> void:
	nav_agent.set_target_position(at)
	behavior.blackboard.set_var(&"move_to_target", true)
	behavior.blackboard.set_var(&"target_position", at)

func set_movement_from_nav() -> Vector3:
	var curr_pos := global_position
	var next_pos: Vector3
	if nav_agent.is_navigation_finished():
		next_pos = behavior.blackboard.get_var(&"target_position")
	else:
		next_pos = nav_agent.get_next_path_position()
	var dif := next_pos - curr_pos
	var dist := dif.length()
	movement = Vector2(dif.x, dif.z).normalized() * minf(1.0, dist)
	return dif

func _physics_process(delta: float) -> void:
	var move_speed := 1.0
	match prone_state:
		ProneState.Stand: move_speed = speed_stand
		ProneState.Crouch: move_speed = speed_crouch
		ProneState.Crawl: move_speed = speed_crawl
	if _sprinting:
		move_speed *= 2.0
	
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
			
			# TODO: Footstep sounds.
			var col: Node = %ray_coyote.get_collider()
			if col and "physics_material_override" in col and col.physics_material_override is SurfaceMaterial:
				var mat: SurfaceMaterial = col.physics_material_override
				var sound_id: String
				match mat.resource_path:
					"res://assets/surfaces/grass.tres":
						sound_id = "grass_%s" % randi_range(1, 15)
					"res://assets/surfaces/concrete.tres":
						sound_id = "concrete_%s" % randi_range(1, 15)
					"res://assets/surfaces/wood.tres":
						sound_id = "wood_%s" % randi_range(1, 15)
					"res://assets/surfaces/carpet.tres":
						sound_id = "carpet_%s" % randi_range(1, 15)
				var audio: AudioStreamPlayer3D = Assets.create_audio_player(sound_id)
				add_child(audio)
				audio.play(0.1)
				audio.finished.connect(func():
					audio.queue_free())
		
		if _was_in_air:
			_was_in_air = false
			landed.emit(1.0) # TODO: Meters fallen.
	
	_was_in_air = not body.is_on_floor()
	
	if nav_agent.avoidance_enabled:
		nav_agent.velocity = vel
	else:
		body.velocity = vel
		body.move_and_slide()
	
	if movement.length() >= 0.1 and (body.global_position - _last_position).length() < .001:
		_stuck_time += delta
		_stuck_time = minf(_stuck_time, 1.0)
	else:
		if _stuck_time > 0.0:
			_stuck_time -= delta * 3.0
	
	_last_position = body.global_position

func is_stuck() -> bool:
	return _stuck_time >= 1.0

func fix_direction() -> void:
	# Transfer rotation to proper node.
	%direction.rotation.y = rotation.y
	rotation.y = 0

#func unequip_slot(slot: StringName = &""):
	#if not slot in _equipped: return
	#var item: ItemNode = _equipped[slot]
	#item.damage_dealt.disconnect(damage_dealt.emit)
	#_equipped.erase(slot)

func get_direction() -> float: return %direction.rotation.y
func set_direction(dir: float): %direction.rotation.y = dir

func focus_start():
	_focusing = true
	focus_started.emit()

func focus_stop():
	_focusing = false
	focus_stopped.emit()

func interact_alt_start() -> bool:
	if _interactive:
		_interacting = _interactive
		_interacting.interaction_pressed(self, Interactive.Form.INTERACT_ALT)
		return true
	return false

func interact_alt_stop() -> bool:
	if _interacting:
		_interacting.interaction_released(self)
		_interacting = null
		return true
	return false

func interact_start() -> bool:
	if _interactive:
		_interacting = _interactive
		_interacting.interaction_pressed(self)
		return true
	return false

func interact_stop() -> bool:
	if _interacting:
		_interacting.interaction_released(self)
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

func stand(): prone_state = ProneState.Stand
func crouch(): prone_state = ProneState.Crouch
func crawl(): prone_state = ProneState.Crawl

func is_focusing() -> bool: return _focusing
func is_crouching() -> bool: return prone_state == ProneState.Crouch or _next_prone_state == ProneState.Crouch
func is_crawling() -> bool: return prone_state == ProneState.Crawl or _next_prone_state == ProneState.Crawl
func is_standing() -> bool: return prone_state == ProneState.Stand or _next_prone_state == ProneState.Stand

func freeze() -> void:
	body.collision_mask = 0
	direction = 0.0
	set_process(false)
	set_physics_process(false)

func unfreeze() -> void:
	body.collision_mask = 1
	fix_direction()
	set_process(true)
	set_physics_process(true)

func is_equipped(slot_id: StringName) -> bool:
	return get_equipped(slot_id) != null

func get_equipped(slot_id: StringName) -> ItemNode:
	return _equipped.get(slot_id)

func equip(item: ItemNode, slot_id: StringName = primary_equip_slot) -> bool:
	if is_equipped(slot_id):
		unequip(slot_id)
	
	_equipped[slot_id] = item
	var parent := get_node_or_null("%equip_" + slot_id)
	item._equipped(self, parent)
	equipped.emit(item, slot_id)
	#item.damage_dealt.connect(damage_dealt.emit)
	return true

func unequip(slot_id: StringName = primary_equip_slot) -> bool:
	var item: ItemNode = get_equipped(slot_id)
	if not item: return false
	if item.info:
		if item.info._node_unequipped(item):
			item._unequipped()
			_equipped.erase(slot_id)
			unequipped.emit(item, slot_id)
			return true
		return false
	else:
		item._unequipped()
		_equipped.erase(slot_id)
		unequipped.emit(item, slot_id)
		return true

func get_primary() -> ItemNode:
	return _equipped.get(primary_equip_slot)

func fire_start() -> bool:
	var primary := get_primary()
	if not primary or not primary.info: return false
	return primary.info._node_use(primary)

func fire_stop() -> bool: return true

func reload_start() -> bool:
	var primary := get_primary()
	if not primary or not primary.info: return false
	return primary.info._node_reload(primary)

func reload_stop() -> bool: return true
