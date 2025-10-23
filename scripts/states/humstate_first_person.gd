extends HumanoidState

var camera: CameraTarget

func _enter_tree() -> void:
	camera = Prefabs.create(&"camera_first_person", humanoid)

func _exit_tree() -> void:
	humanoid.remove_child(camera)
	camera.queue_free()

func _physics_process(_delta: float) -> void:
	var dir := camera.camera.global_rotation.y
	humanoid.direction = dir + PI * .5
	
	var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	input_dir = input_dir.rotated(-dir)
	
	var move_speed := 5.0
	var sprint_speed := 9.0
	var speed := move_speed
	if Input.is_action_pressed(&"sprint"):
		speed = sprint_speed
	humanoid.movement = input_dir * speed
	
	if Input.is_action_just_pressed(&"jump"):
		humanoid.jump = true
