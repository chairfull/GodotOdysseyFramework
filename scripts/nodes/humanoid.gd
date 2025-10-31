class_name Humanoid extends Agent

signal jumped() ## Called after jumping.
signal landed(meters: float) ## Called when hitting the floor.
signal prone_state_changed()

enum ProneState { Stand, Crouch, Kneel, Crawl }

@onready var damageable: Damageable = %damageable
@onready var ray_coyote: RayCast3D = $ray_coyote
var char_info: CharacterInfo
var speed_stand := 3.0
var speed_crouch := 1.0
var speed_crawl := 0.25
var _next_prone_state := ProneState.Stand
var prone_state := ProneState.Stand
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force := 6.0
var _jumping := false
var _jump_cancel := false
var looking_at: Vector3
var visual: PackedScene ## TODO:
var _control_state: HumanoidState
var _sprinting := false
var _was_in_air := false
var _last_position: Vector3
var _held_item: ItemNode
var _focusing := false
var _interacting: Interactive
var _tween_item: Tween

func _ready() -> void:
	super()
	%model.get_node("%animation_tree").humanoid = self

func anim_travel(to: StringName):
	%model.get_node("%animation_tree").travel(to)

func _control_started(con: Controller):
	super(con)
	if is_player_controlled():
		con.view_state_changed.connect(_update_control_state)
		_update_control_state()

func _control_ended(con: Controller):
	super(con)
	set_control_state(&"")
	con.view_state_changed.disconnect(_update_control_state)
	print("Control ended...")

func freeze():
	super()
	if _control_state:
		_control_state.process_mode = Node.PROCESS_MODE_DISABLED

func unfreeze():
	super()
	if _control_state:
		_control_state.process_mode = Node.PROCESS_MODE_INHERIT

func _update_control_state():
	match controller_player.view_state:
		ControllerPlayer.ViewState.None: set_control_state(&"")
		ControllerPlayer.ViewState.FirstPerson: set_control_state(&"_first_person")
		ControllerPlayer.ViewState.ThirdPerson: set_control_state(&"_third_person")
		ControllerPlayer.ViewState.TopDown: set_control_state(&"_top_down")

func enable_physics(enable := true):
	set_physics_process(enable)
	set_physics_process_internal(enable)

func set_control_state(id: StringName):
	if _control_state:
		remove_child(_control_state)
		_control_state.queue_free()
		_control_state = null
	_control_state = load("res://scripts/states/humstate%s.gd" % id).new()
	_control_state.humanoid = self
	_control_state.name = "state %s" % id
	add_child(_control_state)

func _physics_process(delta: float) -> void:
	if _frozen: return
	
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
		if _was_in_air:
			_was_in_air = false
			landed.emit(1.0) # TODO: Meters fallen.
	
	_was_in_air = not body.is_on_floor()
	
	body.velocity = vel
	body.move_and_slide()
	_last_position = body.global_position

func move_to(pos: Vector3):
	nav_agent.set_target_position(pos)

func interact_start() -> bool:
	if node_interact.is_detecting():
		_interacting = node_interact.get_nearest() as Interactive
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
	
	if _tween_item: _tween_item.kill()
	_tween_item = create_tween()
	_tween_item.set_parallel()
	_tween_item.set_trans(Tween.TRANS_BACK)
	_tween_item.tween_property(item_node, "position", Vector3(0.2, -0.2, -0.2), 0.5)
	_tween_item.tween_property(item_node, "basis", Basis.IDENTITY, 0.5)

func sprint_start():
	_sprinting = true

func sprint_end():
	_sprinting = false

func jump_start():
	_jumping = true

func jump_end():
	_jump_cancel = true

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
