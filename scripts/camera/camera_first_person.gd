class_name CameraFirstPerson extends CameraTarget

var mouse_sensitivity := 0.002

func _enter_tree() -> void:
	CameraMaster.ref.target = camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y = clampf(rotation.y - event.relative.x * mouse_sensitivity, deg_to_rad(-89), deg_to_rad(89))
		camera.rotation.x = clampf(camera.rotation.x - event.relative.y * mouse_sensitivity, deg_to_rad(-89), deg_to_rad(89))
