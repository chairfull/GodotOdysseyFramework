@icon("res://addons/odyssey/icons/detector.svg")
class_name Detector extends Area3D
## Manages a list of things it can see.
## Used for hearing, seeing, and interaction.

signal detected(node: Node3D) ## Noticed something.
signal undetected(node: Node3D) ## Lost something.
signal moved(node: Node3D) ## Something moved.
signal forgot(node: Node3D) ## No longer caring about this node.

class Tracked extends Resource:
	@export var tracking := false
	@export var confidence := 0.0
	@export var was_ever_detected := false
	@export var in_view := false
	@export var last_position := Vector3.ZERO # Position node was in last detection..
	@export var last_direction := Vector3.ZERO # Direction node was moving last detection.
	@export var remember_time := 1.0 # How long until after undetected do we forget this node.
	func is_detected() -> bool:
		return confidence >= 0.9

@export var confidence_increase_scale := 4.0
@export var confidence_decrease_scale := 1.0
@export var memory_seconds := 1.0 ## How long after undetected to forget about the node.
@export var simple := false
@export_range(1, 3) var raycasts := 3 ## Raycasts to check that node isn't occluded.
@export var enabled := true: set=set_enabled
var ignore: Array[Node3D]
var _nodes: Dictionary[Node3D, Tracked] ## Nodes in area, but may not be visible w raycast.
var _debug_lines: Array[Array]

func _ready() -> void:
	set_physics_process(false)
	area_entered.connect(_entered)
	area_exited.connect(_exited)
	body_entered.connect(_entered)
	body_exited.connect(_exited)

func set_enabled(e: bool) -> void:
	enabled = e
	monitoring = enabled
	set_process(_nodes.size() > 0.0)

func get_nearest(pos: Vector3) -> Node3D:
	var dist := INF
	var nearest: Node3D = null
	for node in _nodes:
		var d := pos.distance_to(node.global_position)
		if d < dist:
			dist = d
			nearest = node
	return nearest

func was_ever_detected(node: Node3D) -> bool:
	return node in _nodes and _nodes[node].was_ever_detected

func get_last_detected_position(node: Node3D, default := Vector3.ZERO) -> Vector3:
	if was_ever_detected(node):
		return _nodes[node].last_position
	return default

func get_last_detected_direction(node: Node3D, default := Vector3.ZERO) -> Vector3:
	if was_ever_detected(node):
		return _nodes[node].last_direction
	return default

func get_detection_confidence(node: Node3D) -> float:
	if node in _nodes: return _nodes[node].confidence
	return 0.0

func _entered(node: Node3D):
	if node in ignore: return
	if node == owner: return
	if not node in _nodes:
		_nodes[node] = Tracked.new()
		set_physics_process(_nodes.size() > 0)
	_nodes[node].tracking = true

func _exited(node: Node3D):
	if node in ignore: return
	if node == owner: return
	if node in _nodes:
		_nodes[node].tracking = false

func _physics_process(delta: float) -> void:
	_debug_lines.clear()
	
	for node in _nodes:
		var tracking := _nodes[node]
		var was_detec := tracking.is_detected()
		
		if tracking.tracking and _is_ray_path_clear(node):
			tracking.in_view = true
			tracking.confidence = minf(tracking.confidence + confidence_increase_scale * delta, 1.0)
		else:
			tracking.in_view = false
			tracking.confidence = maxf(tracking.confidence - confidence_decrease_scale * delta, 0.0)
		
		var is_detect := tracking.is_detected()
		
		if was_detec != is_detect:
			if is_detect:
				detected.emit(node)
			else:
				undetected.emit(node)
		
		if is_detect:
			tracking.remember_time = memory_seconds
			tracking.was_ever_detected = true
			var last_pos: Vector3 = tracking.last_position
			var curr_pos := node.global_position
			if last_pos != curr_pos:
				tracking.last_position = curr_pos
				# Only update direction if they were moving.
				if (curr_pos - last_pos).length() > .01:
					tracking.last_direction = curr_pos - last_pos
				moved.emit(node)
		else:
			tracking.remember_time -= 1.0 * delta
			if tracking.remember_time <= 0.0:
				_forget.call_deferred(node)

func _forget(node: Node3D) -> void:
	_nodes.erase(node)
	forgot.emit(node)
	if _nodes.size() == 0:
		set_process(false)

func _is_ray_path_clear(target: Node3D) -> bool:
	if simple:
		return true
	var from := global_position
	var targ_pos := target.global_position + Vector3.UP * (.5 + randf_range(0.0, 0.5))
	var targ_radius := 1.0# ((target.get_child(0) as CollisionShape3D).shape as SphereShape3D).radius
	var space_state := get_world_3d().direct_space_state
	for i in raycasts:
		var to := targ_pos + targ_radius * Rand.point_on_sphere() * (i / float(raycasts))
		_debug_lines.append([from, to])
		var query := PhysicsRayQueryParameters3D.create(from, to, 1 << 0)
		query.exclude = [get_rid(), target.get_rid()] # Ignore ear/source
		var result := space_state.intersect_ray(query)
		if result:
			return false
	return true
