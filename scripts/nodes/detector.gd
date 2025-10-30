class_name Detector extends Area3D
## Manages a list of things it can see.
## Used for hearing, seeing, and interaction.

signal started() ## Started noticing things.
signal entered(area: Node3D) ## Noticed something.
signal exited(area: Node3D) ## Lost something.
signal moved(area: Node3D)
signal ended() ## Stopped noticing anything.

var _nodes: Array[Node3D]
var _visible: Array[Node3D]
var _confidence: Dictionary[Node3D, float]
var _last_position: Dictionary[Node3D, Vector3]

func _ready() -> void:
	set_physics_process(false)
	
	area_entered.connect(_entered)
	area_exited.connect(_exited)
	body_entered.connect(_entered)
	body_exited.connect(_exited)

func is_detecting() -> bool:
	return _visible.size() > 0

func get_nearest() -> Node3D:
	var dist := INF
	var near: Node3D = null
	for area in _visible:
		var d := global_position.distance_to(area.global_position)
		if d < dist:
			dist = d
			near = area
	return near

func get_last_position(area: Node3D, default := Vector3.ZERO) -> Vector3:
	return _last_position.get(area, default)

func _entered(node: Node3D):
	if node == owner: return
	if not node in _nodes:
		_nodes.append(node)
		if _nodes.size() == 1:
			set_physics_process(true)

func _exited(node: Node3D):
	if node == owner: return
	if not node in _nodes:
		_nodes.erase(node)
		_invisible(node)
		if _nodes.size() == 0:
			set_physics_process(false)

func _physics_process(_delta: float) -> void:
	for node in _nodes:
		if _is_ray_path_clear(node):
			_confidence[node] = _confidence.get(node, 0.0) + 1.0
			
			if not node in _visible:
				_visible.append(node)
				entered.emit(node)
				if _visible.size() == 1:
					started.emit()
			
			var last: Vector3 = _last_position.get(node, Vector3.ZERO)
			var curr := node.global_position
			if last != curr:
				_last_position[node] = curr
				moved.emit(node)
		else:
			_confidence[node] = _confidence.get(node, 0.0) - 0.1
			if _confidence[node] < 0.0:
				_confidence[node] = 0.0
				_invisible(node)

func _invisible(node: Node3D):
	if not node in _visible:
		return
	
	_visible.erase(node)
	exited.emit(node)
	if _visible.size() == 0:
		ended.emit()
	 
	# Remove last position from trackers after a minute?
	Global.wait(60.0, func():
		if not node in _nodes:
			_last_position.erase(node))

func _is_ray_path_clear(target: Node3D) -> bool:
	return true
	#var from := global_position
	#var targ_pos := target.global_position
	#var targ_radius := ((target.get_child(0) as CollisionShape3D).shape as SphereShape3D).radius
	#var space_state := get_world_3d().direct_space_state
	#const RAY_COUNT := 3
	#for i in RAY_COUNT:
		#var to := targ_pos + targ_radius * Rand.point_on_sphere() * (i / float(RAY_COUNT))
		#var query := PhysicsRayQueryParameters3D.create(from, to, 1 << 1)
		#query.exclude = [self, target]  # Ignore ear/source
		#var result := space_state.intersect_ray(query)
		#if result:
			#return false
	#return true
