class_name CameraTopDown extends CameraTarget

@onready var cursor: MeshInstance3D = %cursor

func _enter_tree() -> void:
	CameraMaster.ref.target = camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	var move := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	var speed := 10.0
	global_position += Vector3(move.x, 0.0, move.y) * speed * delta
