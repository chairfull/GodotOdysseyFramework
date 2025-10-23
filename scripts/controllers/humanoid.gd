class_name Humanoid extends Controllable

enum ViewState { None, FirstPerson, ThirdPerson, TopDown }
var view_state := ViewState.FirstPerson: set=set_view_state

@onready var nav_agent: NavigationAgent3D = %agent
@onready var visual_root: Node3D = %visual_root
@onready var ray_coyote: RayCast3D = $ray_coyote
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force := 4.5
var movement := Vector2.ZERO
var jump := false

var state: HumanoidState

@export_range(-180, 180, 0.01, "radians_as_degrees") var direction: float:
	get: return %visual_root.rotation.y
	set(dir): %visual_root.rotation.y = dir

func _ready() -> void:
	set_view_state(ViewState.FirstPerson)

func enable_physics(enable := true):
	set_physics_process(enable)
	set_physics_process_internal(enable)

func set_view_state(vs: ViewState):
	view_state = vs
	if state:
		remove_child(state)
		state.queue_free()
		state = null
	match view_state:
		ViewState.FirstPerson: state = load("res://scripts/states/humstate_first_person.gd").new()
		ViewState.ThirdPerson: state = load("res://scripts/states/humstate_third_person.gd").new()
		ViewState.TopDown: state = load("res://scripts/states/humstate_top_down.gd").new()
		_: state = load("res://scripts/states/humstate.gd").new()
	if state:
		state.humanoid = self
		add_child(state)

func _physics_process(delta: float) -> void:
	var body: CharacterBody3D = convert(self, TYPE_OBJECT)
	
	if not nav_agent.is_navigation_finished():
		var curr_pos := global_position
		var next_pos := nav_agent.get_next_path_position()
		body.velocity = curr_pos.direction_to(next_pos)  * 5.0
		var ang := Vector2(curr_pos.x, curr_pos.z).direction_to(Vector2(next_pos.x, next_pos.z))
		direction = lerp_angle(direction, atan2(-ang.y, ang.x), delta * 10.0)
	else:
		var vel := Vector3(movement.x, body.velocity.y, movement.y)
		if body.is_on_floor():
			if jump:
				vel.y = jump_force
				jump = false
			else:
				vel.y = -0.01
		else:
			vel.y -= gravity * delta
		body.velocity = vel
	
	body.move_and_slide()

func move_to(pos: Vector3):
	nav_agent.set_target_position(pos)
