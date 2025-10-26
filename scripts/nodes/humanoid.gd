class_name Humanoid extends Controllable

signal interactives_changed() ## Called when interactive items entered or exited the interactive range.
signal jumped() ## Called after jumping.
signal landed(meters: float) ## Called when hitting the floor.

enum ProneState { Stand, Crouch, Kneel, Crawl }

@onready var interactor: Area3D = %interactor
@onready var nav_agent: NavigationAgent3D = %agent
@onready var direction_node: Node3D = %direction
@onready var ray_coyote: RayCast3D = $ray_coyote
var prone_state := ProneState.Stand
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force := 4.5
var movement := Vector2.ZERO
var jump := false
var character: Character
var looking_at: Vector3
var _control_state: HumanoidState
var _interactives: Array[Interactive]
var _was_in_air := false
var _last_position: Vector3
var _held_item: ItemNode

@export_range(-180, 180, 0.01, "radians_as_degrees") var direction: float:
	get: return %direction.rotation.y
	set(dir): %direction.rotation.y = dir

func _ready() -> void:
	nav_agent.navigation_finished.connect(func(): movement = Vector2.ZERO)
	interactor.area_entered.connect(func(a):
		if not a in _interactives:
			_interactives.append(a)
			interactives_changed.emit())
	interactor.area_exited.connect(func(a):
		if a in _interactives:
			_interactives.erase(a)
			interactives_changed.emit())
	%mesh.get_node("%animation_tree").humanoid = self
	
	_held_item = load("res://scenes/prefabs/held_shooter.tscn").instantiate()
	%head.add_child(_held_item)
	_held_item.mount = self
	_held_item.item._node_equipped(_held_item)
	_held_item.position = Vector3(0.2, -0.2, -0.2)

func _control_started():
	super()
	if is_player_controlled():
		controller_player.view_state_changed.connect(_update_control_state)
		_update_control_state()
		print("CONTROL STARTED ", controller_player, controller_player.view_state_changed.get_connections())
		
func _update_control_state():
	print(controller_player.view_state)
	match controller_player.view_state:
		ControllerPlayer.ViewState.None: set_control_state(&"")
		ControllerPlayer.ViewState.FirstPerson: set_control_state(&"_first_person")
		ControllerPlayer.ViewState.ThirdPerson: set_control_state(&"_third_person")
		ControllerPlayer.ViewState.TopDown: set_control_state(&"_top_down")

func _control_ended():
	super()
	set_control_state(&"")

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
	var body: CharacterBody3D = convert(self, TYPE_OBJECT)
	
	if not nav_agent.is_navigation_finished():
		var curr_pos := global_position
		var next_pos := nav_agent.get_next_path_position()
		var dir := next_pos - curr_pos
		dir.y = 0.0
		dir = dir.normalized()
		dir *= 5.0
		movement.x = dir.x
		movement.y = dir.z
		var ang := Vector2(curr_pos.x, curr_pos.z).direction_to(Vector2(next_pos.x, next_pos.z))
		direction = lerp_angle(direction, atan2(-ang.y, ang.x), delta * 10.0)
	
	var vel := Vector3(movement.x, body.velocity.y, movement.y)
	if jump and (body.is_on_floor() or Cheats.infinite_jumping):
		vel.y = jump_force
		jump = false
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

func interact() -> bool:
	if _interactives:
		_interactives[0].interact(self)
		return true
	return false

func fire() -> bool:
	return _held_item.item._node_use(_held_item)

func reload() -> bool:
	return _held_item.item._node_reload(_held_item)
