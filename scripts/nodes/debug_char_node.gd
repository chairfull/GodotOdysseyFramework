extends Node2D

@onready var node: CharNode = get_parent()
@export var enabled := true: set=set_enabled

var nav_path: PackedVector3Array
var detected: Array[Node3D]

func set_enabled(e: bool) -> void:
	enabled = e
	set_process(enabled)

func _ready() -> void:
	await get_tree().process_frame
	node.nav_agent.path_changed.connect(_path_changed)
	node.eyes.detected.connect(_tracking_start)
	node.eyes.forgot.connect(_tracking_stop)
	set_process(enabled)

func _tracking_start(n: Node3D) -> void:
	if not n in detected: detected.append(n)
func _tracking_stop(n: Node3D) -> void:
	if n in detected: detected.erase(n)

func _path_changed() -> void:
	nav_path = node.nav_agent.get_current_navigation_path()

func _process(_delta: float) -> void:
	var _s2 = DebugDraw3D.new_scoped_config().set_viewport(Controllers.player.viewport)
	DebugDraw3D.config.force_use_camera_from_scene = true
	DebugDraw3D.config.frustum_culling_mode = DebugDraw3DConfig.FRUSTUM_DISABLED
	DebugDraw3D.config.use_frustum_culling = false
	
	var det: Detector = node.eyes
	var off := Vector3.UP * .5
	DebugDraw3D.draw_text(node.global_position + off, "Seen: %s" % det._nodes.size())
	for node_seen in det._nodes:
		var confidence := det.get_detection_confidence(node_seen)
		var clr := Color.TOMATO.lerp(Color.GREEN_YELLOW, confidence) 
		DebugDraw3D.draw_line(node.global_position + off, node_seen.global_position + off, clr)
	
	# Confidence lines.
	for line in det._debug_lines:
		DebugDraw3D.draw_line(line[0], line[1], line[2])
	
	# Last visible position.
	for n in detected:
		var last_pos := det.get_last_detected_position(n)
		var last_dir := det.get_last_detected_direction(n)
		#DebugDraw3D.draw_sphere(last, 0.5, Color.PINK)
		DebugDraw3D.draw_arrow(last_pos, last_pos + last_dir.normalized(), Color.PINK)
	
	DebugDraw3D.draw_line_path(nav_path, Color.PALE_VIOLET_RED)
	
