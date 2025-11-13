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
	
	if not remote_node: return
	
	var start_pos := remote_node.global_position
	var start_rot := remote_node.global_rotation
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.set_trans(tween_trans)
	_tween.set_ease(tween_ease)
	_tween.tween_method(func(blend: float):
		remote_node.global_position = start_pos.lerp(global_position, blend)
		var end_rot := global_rotation
		remote_node.global_rotation = Vector3(
			lerp_angle(start_rot.x, end_rot.x, blend),
			lerp_angle(start_rot.y, end_rot.y, blend),
			lerp_angle(start_rot.z, end_rot.z, blend)
			)
		, 0.0, 1.0, tween_duration)
	_tween.finished.connect(func():
		remote_path = get_path_to(n)
		finished.emit())
