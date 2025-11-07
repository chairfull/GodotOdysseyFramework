class_name RemoteTransform3DTweened extends RemoteTransform3D
## Instead of snapping, remote_node is lerped into place first.
## Can also call move_to_local() manually to set a new position.

signal finished()

@export var remote_node: Node3D: set=set_node
@export var tween_duration := 0.5
@export var tween_trans := Tween.TRANS_SINE
@export var tween_ease := Tween.EASE_IN_OUT
var _tween: Tween

func set_node(n: Node3D):
	if remote_node == n: return
	remote_node = n
	remote_path = get_path_to(n)
	
	if not remote_node: return
	
	var end_pos := position
	var end_rot := basis
	global_position = remote_node.global_position
	global_rotation = remote_node.global_rotation
	move_to_local(end_pos, end_rot)

func move_to_local(end_pos: Vector3, end_rot: Basis):
	var start_pos := position
	var start_rot := basis
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.set_trans(tween_trans)
	_tween.set_ease(tween_ease)
	_tween.tween_method(func(blend: float):
		position = start_pos.lerp(end_pos, blend)
		basis = start_rot.slerp(end_rot, blend)
		, 0.0, 1.0, tween_duration)
	_tween.finished.connect(finished.emit)
