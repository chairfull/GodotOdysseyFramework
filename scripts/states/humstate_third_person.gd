extends HumanoidState

var camera: CameraTarget

func _enter_tree() -> void:
	camera = Prefabs.create(&"camera_third_person", humanoid)

func _exit_tree() -> void:
	humanoid.remove_child(camera)
	camera.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		if humanoid._interactives:
			humanoid._interactives[0].interact(humanoid)
			get_viewport().set_input_as_handled()
	
func _physics_process(delta: float) -> void:
	var dir := camera.camera.global_rotation.y
	
	var input_dir := ControllerPlayer.get_move_vector()
	input_dir = input_dir.rotated(-dir)
	
	if input_dir:
		humanoid.direction = lerp_angle(humanoid.direction, -input_dir.angle(), delta * 10.0)
		
	var move_speed := 5.0
	var sprint_speed := 9.0
	var speed := move_speed
	if Input.is_action_pressed(&"sprint"):
		speed = sprint_speed
	humanoid.movement = input_dir * speed
	
	if Input.is_action_just_pressed(&"jump"):
		humanoid.jump = true
