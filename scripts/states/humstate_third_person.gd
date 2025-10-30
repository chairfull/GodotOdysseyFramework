extends HumanoidState

var camera: CameraTarget
var _crouch_hold_time := 0.0
var _crouch_held := false
var _aim_held := false

func _enter_tree() -> void:
	camera = humanoid.get_node_or_null("camera")
	if not camera:
		camera = Assets.create_prefab(&"camera_follow", humanoid)
		camera.name = "camera"
	camera.set_third_person()
	humanoid.get_node(^"%model").visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		if humanoid.interact_start():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"fire"):
		if humanoid.fire():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"reload"):
		if humanoid.reload():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"jump"):
		if humanoid.prone_state in [Humanoid.ProneState.Crouch, Humanoid.ProneState.Crawl]:
			humanoid.stand()
		else:
			humanoid.jump_start()
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"jump"):
		if humanoid.jump_end():
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"drop"):
		if humanoid.drop():
			get_viewport().set_input_as_handled()
	
	elif event.is_action_pressed(&"aim"):
		_aim_held = true
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"aim"):
		_aim_held = false
		get_viewport().set_input_as_handled()
		
	elif event.is_action_pressed(&"crouch", false, true):
		_crouch_held = true
		if humanoid.is_standing():
			humanoid.crouch()
		elif humanoid.is_crouching():
			humanoid.stand()
		elif humanoid.is_crawling():
			humanoid.crouch()
		get_viewport().set_input_as_handled()
	elif event.is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		get_viewport().set_input_as_handled()
		
func _process(delta: float) -> void:
	camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	humanoid.get_node("%head").global_rotation = camera.camera.global_rotation

	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not humanoid.is_crawling():
				humanoid.crawl()
	
func _physics_process(delta: float) -> void:
	var dir := camera.camera.global_rotation.y
	
	var input_dir := ControllerPlayer.get_move_vector()
	input_dir = input_dir.rotated(-dir)
	
	if input_dir:
		humanoid.direction = lerp_angle(humanoid.direction, -input_dir.angle() - PI * .5, delta * 10.0)
	
	humanoid.movement = input_dir
