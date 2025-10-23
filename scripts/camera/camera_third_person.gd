class_name CameraThirdPerson extends CameraTarget

@onready var cursor: MeshInstance3D = %cursor
@export var angle := 0.0
@export var height := 3.0
@export var dist := 10.0

func _enter_tree() -> void:
	CameraMaster.ref.target = camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	if Input.is_action_pressed(&"rotate_camera_left"):
		angle -= 1.0 * delta
	if Input.is_action_pressed(&"rotate_camera_right"):
		angle += 1.0 * delta
	var dst := Vector3(cos(angle) * dist, dist, sin(angle) * dist)
	var trg := global_position
	camera.look_at_from_position(trg + dst, trg)
