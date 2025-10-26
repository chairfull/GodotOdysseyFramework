class_name CameraFirstPerson extends CameraTarget

var mouse_sensitivity := 0.002
var rot_y := 0.0
var rot_x := 0.0

func _enter_tree() -> void:
	make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rot_y -= event.relative.x * mouse_sensitivity
		rot_x -= event.relative.y * mouse_sensitivity
		rot_x = clampf(rot_x, deg_to_rad(-89), deg_to_rad(89))

func _process(delta: float) -> void:
	rotation.y = lerp_angle(rotation.y, rot_y, delta * 50.0)
	camera.rotation.x = lerp_angle(camera.rotation.x, rot_x, delta * 50.0)
