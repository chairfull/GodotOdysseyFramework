class_name CameraThirdPerson extends CameraTarget

@onready var cursor: MeshInstance3D = %cursor
@export var angle := 0.0
@export var height := 3.0
@export var dist := 5.0

func _enter_tree() -> void:
	make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	var rot := Input.get_axis(&"rotate_camera_left", &"rotate_camera_right")
	if rot:
		angle -= 1.0 * rot * delta
	var dst := Vector3(cos(angle), .5, sin(angle)) * 3
	var trg := global_position + Vector3.UP
	camera.look_at_from_position(trg + dst, trg)
