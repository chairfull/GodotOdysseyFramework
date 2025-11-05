class_name CameraFollow extends CameraTarget

@onready var pivot: Node3D = %pivot
@onready var spring_arm: SpringArm3D = %spring_arm
@onready var offset: Node3D = %offset

@export var target: Node3D
@export var mouse_sensitivity := 0.02
@export var rot_y := 0.0
@export var rot_x := 0.0
@export var view_mode := ViewMode.FIRST_PERSON
@export var focusing := false

var fov_focused := 30.0
var fov_unfocused := 75.0
var focus_offset := Vector2(10.0, 10.0)
var _noise := FastNoiseLite.new()
var _noise_time := randf()
var _noise_speed := 10.0
#var _noise_scale := Vector2(0.3, 0.1)

var push_out := Vector2.ZERO: set=set_push_out
var aim_offset_y := 0.0
var aim_look_dist := 0.0

func _ready() -> void:
	_noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	process_priority = 100
	process_physics_priority = 100

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func is_third_person() -> bool: return view_mode == ViewMode.THIRD_PERSON
func is_first_person() -> bool: return view_mode == ViewMode.FIRST_PERSON

func focus():
	focusing = true
	aim_look_dist = pivot.global_position.distance_to((target as Humanoid).looking_at)
	UTween.parallel(camera, { "fov": fov_focused }, 0.2)
	if is_third_person():
		UTween.parallel(self, { "push_out": Vector2(1, 0.0) }, 0.2)

func unfocus():
	focusing = false
	aim_look_dist = spring_arm.spring_length
	UTween.parallel(camera, { "fov": fov_unfocused }, 0.2)
	if is_third_person():
		UTween.parallel(self, { "push_out": Vector2.ZERO }, 0.2)

func set_push_out(off: Vector2):
	push_out = off
	camera.position = Vector3(off.x, off.y, 0.0)
	aim_offset_y = atan2(off.x, aim_look_dist) # Correct the rotation.

func set_first_person() -> Signal:
	view_mode = ViewMode.FIRST_PERSON
	var twn := UTween.parallel(self, {"spring_arm:spring_length": 0.0}, 0.5, &"spring_length")
	return twn.finished

func set_third_person() -> Signal:
	view_mode = ViewMode.THIRD_PERSON
	var twn := UTween.parallel(self, {"spring_arm:spring_length": 3.0}, 0.5, &"spring_length")
	return twn.finished

func get_fov_scale() -> float:
	return remap(camera.fov, fov_unfocused, fov_focused, 0.0, 1.0)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var fov_scale := lerpf(0.01, 0.001, get_fov_scale())
		rot_y -= event.relative.x * fov_scale
		rot_x -= event.relative.y * fov_scale
		rot_x = clampf(rot_x, deg_to_rad(-89), deg_to_rad(89))

func _process(delta: float) -> void:
	
	pivot.rotation.y = lerp_angle(pivot.rotation.y, rot_y + aim_offset_y, 30.0 * delta)
	pivot.rotation.x = lerp_angle(pivot.rotation.x, rot_x, 30.0 * delta)
	
	_noise_time += delta * _noise_speed
	#var fov_scale := get_fov_scale()
	#camera.h_offset = _noise.get_noise_1d(_noise_time + 123.456) * _noise_scale.x * fov_scale
	#camera.v_offset = _noise.get_noise_1d(_noise_time + 654.321) * _noise_scale.y * fov_scale
	
	#match view_mode:
		#ViewMode.FIRST_PERSON:
			#if target:
				#global_position = target.global_position
		#
		#ViewMode.THIRD_PERSON:
			#if target:
				#global_position = global_position.slerp(target.global_position, 20.0 * delta)
